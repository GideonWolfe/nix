#!/usr/bin/env python3
"""
Portapack SD card preparation script.
Downloads the latest Portapack firmware and FlipperZero-Subghz-DB files.
"""

import os
import sys
import json
import urllib.request
import urllib.error
import zipfile
import shutil
import time
import subprocess
from pathlib import Path


def format_bytes(bytes_size):
    """Format bytes into human readable format."""
    for unit in ['B', 'KB', 'MB', 'GB']:
        if bytes_size < 1024.0:
            return f"{bytes_size:.1f} {unit}"
        bytes_size /= 1024.0
    return f"{bytes_size:.1f} TB"


def progress_hook(block_num, block_size, total_size):
    """Progress hook for urllib.request.urlretrieve."""
    downloaded = block_num * block_size
    if total_size > 0:
        percent = min(100, (downloaded / total_size) * 100)
        downloaded_str = format_bytes(downloaded)
        total_str = format_bytes(total_size)
        bar_length = 30
        filled_length = int(bar_length * downloaded // total_size)
        bar = '█' * filled_length + '░' * (bar_length - filled_length)
        print(f"\r  Progress: [{bar}] {percent:.1f}% ({downloaded_str}/{total_str})", end='', flush=True)
    else:
        downloaded_str = format_bytes(downloaded)
        print(f"\r  Downloaded: {downloaded_str}", end='', flush=True)


def fetch_latest_release():
    """Fetch the latest release information from GitHub API."""
    print("Fetching latest release information...")
    
    try:
        with urllib.request.urlopen("https://api.github.com/repos/portapack-mayhem/mayhem-firmware/releases/latest") as response:
            data = json.loads(response.read().decode())
            tag_name = data.get('tag_name')
            
            if not tag_name:
                raise ValueError("No tag_name found in release data")
                
            return tag_name
    except (urllib.error.URLError, json.JSONDecodeError, ValueError) as e:
        print(f"Error: Could not fetch latest release information: {e}")
        sys.exit(1)


def download_file(url, filename):
    """Download a file from URL to local filename with progress."""
    try:
        print(f"Downloading {filename}...")
        urllib.request.urlretrieve(url, filename, reporthook=progress_hook)
        print()  # New line after progress bar
        
        if not os.path.exists(filename):
            raise FileNotFoundError(f"Failed to download {filename}")
            
        file_size = os.path.getsize(filename)
        print(f"  Successfully downloaded {filename} ({format_bytes(file_size)})")
        return True
    except (urllib.error.URLError, FileNotFoundError) as e:
        print(f"\nError downloading {filename}: {e}")
        return False


def extract_zip(zip_file, extract_to="."):
    """Extract ZIP file contents."""
    try:
        print("Extracting contents...")
        with zipfile.ZipFile(zip_file, 'r') as zip_ref:
            zip_ref.extractall(extract_to)
        return True
    except zipfile.BadZipFile as e:
        print(f"Error extracting {zip_file}: {e}")
        return False


def copy_directory_contents(source_dir, target_dir):
    """Copy contents from source directory to target directory."""
    try:
        source_path = Path(source_dir)
        target_path = Path(target_dir)
        
        if not source_path.exists():
            print(f"Warning: Source directory {source_dir} does not exist")
            return False
            
        if not target_path.exists():
            print(f"Warning: Target directory {target_dir} does not exist")
            return False
            
        print(f"Copying subghz files to {target_dir} directory...")
        
        # Copy all files and subdirectories
        for item in source_path.iterdir():
            if item.is_file():
                shutil.copy2(item, target_path)
            elif item.is_dir():
                target_subdir = target_path / item.name
                if target_subdir.exists():
                    shutil.rmtree(target_subdir)
                shutil.copytree(item, target_subdir)
                
        print("Successfully copied subghz files")
        return True
    except Exception as e:
        print(f"Error copying directory contents: {e}")
        return False


def extract_radio_frequencies():
    """Extract radio frequencies using radioref command and organize into FREQMAN directory."""
    print("Extracting local radio frequencies...")
    
    # Create temporary directory and run radioref
    temp_dir = Path("temp_radioref")
    temp_dir.mkdir(exist_ok=True)
    original_cwd = Path.cwd()
    
    try:
        os.chdir(temp_dir)
        subprocess.run(["radioref"], check=False)
        os.chdir(original_cwd)
        
        # Move any output directories to FREQMAN
        freqman_dir = Path("FREQMAN")
        freqman_dir.mkdir(exist_ok=True)
        
        for output_dir in temp_dir.iterdir():
            if output_dir.is_dir():
                target_path = freqman_dir / output_dir.name
                if target_path.exists():
                    shutil.rmtree(target_path)
                shutil.move(str(output_dir), str(target_path))
                print(f"  Moved frequency files: {output_dir.name}")
        
    finally:
        if temp_dir.exists():
            shutil.rmtree(temp_dir)


def cleanup_files(*files_and_dirs):
    """Remove files and directories."""
    for item in files_and_dirs:
        try:
            item_path = Path(item)
            if item_path.is_file():
                item_path.unlink()
            elif item_path.is_dir():
                shutil.rmtree(item_path)
        except Exception as e:
            print(f"Warning: Could not remove {item}: {e}")


def main():
    """Main function to prepare Portapack SD card contents."""
    print("Preparing Portapack SD card contents...")
    
    # Create portapack directory
    portapack_dir = Path("portapack")
    portapack_dir.mkdir(exist_ok=True)
    
    # Change to portapack directory
    os.chdir(portapack_dir)
    
    # Get latest release
    latest_release = fetch_latest_release()
    print(f"Latest firmware version: {latest_release}")
    
    # Remove 'v' prefix if present
    version_number = latest_release.lstrip('v')
    
    # Download firmware
    download_url = f"https://github.com/portapack-mayhem/mayhem-firmware/releases/download/{latest_release}/mayhem_v{version_number}_COPY_TO_SDCARD.zip"
    zip_file = f"mayhem_v{version_number}_COPY_TO_SDCARD.zip"
    
    if not download_file(download_url, zip_file):
        print(f"Error: Failed to download {zip_file}")
        sys.exit(1)
    
    # Extract firmware
    if not extract_zip(zip_file):
        print(f"Error: Failed to extract {zip_file}")
        sys.exit(1)
    
    # Clean up firmware zip
    cleanup_files(zip_file)
    
    # Download FlipperZero-Subghz-DB repository
    print("Downloading FlipperZero-Subghz-DB repository...")
    subghz_repo_url = "https://github.com/Zero-Sploit/FlipperZero-Subghz-DB/archive/refs/heads/main.zip"
    subghz_zip = "FlipperZero-Subghz-DB-main.zip"
    
    if download_file(subghz_repo_url, subghz_zip):
        if extract_zip(subghz_zip):
            # Copy subghz directory contents to SUBGHZ directory
            source_subghz = "FlipperZero-Subghz-DB-main/subghz"
            target_subghz = "SUBGHZ"
            
            if Path(source_subghz).exists() and Path(target_subghz).exists():
                copy_directory_contents(source_subghz, target_subghz)
            else:
                print("Warning: Could not find source subghz directory or target SUBGHZ directory")
        
        # Clean up subghz repo files
        cleanup_files("FlipperZero-Subghz-DB-main", subghz_zip)
    else:
        print("Warning: Failed to download FlipperZero-Subghz-DB repository")
    
    # Extract radio frequencies and organize into FREQMAN directory
    extract_radio_frequencies()
    
    print("Portapack SD card contents ready in ./portapack/")
    print("Copy the contents of this folder to your SD card root directory.")


if __name__ == "__main__":
    main()
