#!/usr/bin/env python3
"""
RadioReference.com frequency extraction utility.
Downloads and parses frequency data from RadioReference pages.
"""

import json
import urllib.request
import urllib.error
import time
import re


def has_frequency_column(table_html):
    """Check if a table has a 'Frequency' column."""
    # Look for thead section first
    thead_match = re.search(r'<thead[^>]*>(.*?)</thead>', table_html, re.DOTALL | re.IGNORECASE)
    if thead_match and "frequency" in thead_match.group(1).lower():
        return True
    
    # Check th tags directly
    th_pattern = r'<th[^>]*>(.*?)</th>'
    th_matches = re.findall(th_pattern, table_html, re.IGNORECASE)
    return any("frequency" in re.sub(r'<[^>]+>', '', th).strip().lower() for th in th_matches)


def extract_tables_from_html(html_content):
    """Extract table data from HTML using regex patterns - simpler than full HTML parsing."""
    
    # Find all table sections with regex
    table_pattern = r'<table[^>]*>(.*?)</table>'
    tables = re.findall(table_pattern, html_content, re.DOTALL | re.IGNORECASE)
    
    extracted_tables = []
    
    for table_html in tables:
        # Skip tables without frequency column
        if not has_frequency_column(table_html):
            continue
        
        # Extract rows from each table
        row_pattern = r'<tr[^>]*>(.*?)</tr>'
        rows = re.findall(row_pattern, table_html, re.DOTALL | re.IGNORECASE)
        
        table_data = []
        for row_html in rows:
            # Extract cells from each row
            cell_pattern = r'<td[^>]*>(.*?)</td>'
            cells = re.findall(cell_pattern, row_html, re.DOTALL | re.IGNORECASE)
            
            # Clean up cell content - remove HTML tags and extra whitespace
            clean_cells = []
            for cell in cells:
                # Remove HTML tags
                clean_cell = re.sub(r'<[^>]+>', '', cell)
                # Clean up whitespace
                clean_cell = ' '.join(clean_cell.split())
                clean_cells.append(clean_cell)
            
            if clean_cells:  # Only add non-empty rows
                table_data.append(clean_cells)
        
        if table_data:
            extracted_tables.append(table_data)
    
    return extracted_tables


def identify_frequency_tables(tables):
    """Convert raw table data to structured frequency data."""
    frequency_tables = []
    
    for table in tables:
        if not table:
            continue
            
        # Convert to structured data
        structured_data = []
        for row in table:
            if not row or not re.match(r'^\d{2,3}\.\d+', row[0].strip()):
                continue
                
            # This looks like a frequency row
            freq_data = {
                "frequency": row[0].strip() if len(row) > 0 else "",
                "license": row[1].strip() if len(row) > 1 else "",
                "type": row[2].strip() if len(row) > 2 else "",
                "tone": row[3].strip() if len(row) > 3 else "",
                "description": row[4].strip() if len(row) > 4 else "",
                "alias": row[5].strip() if len(row) > 5 else "",
                "mode": row[6].strip() if len(row) > 6 else "",
                "category": row[7].strip() if len(row) > 7 else "",
            }
            
            # Only add if we have a valid frequency
            if freq_data["frequency"]:
                structured_data.append(freq_data)
        
        if structured_data:
            frequency_tables.append(structured_data)
    
    return frequency_tables


def extract_context_from_html(html_content):
    """Extract section and table context, matching only frequency tables."""
    
    # Find all tables with frequency columns and their positions
    frequency_table_matches = []
    table_pattern = r'<table[^>]*>(.*?)</table>'
    
    for match in re.finditer(table_pattern, html_content, re.DOTALL | re.IGNORECASE):
        table_html = match.group(1)
        
        # Only include tables with frequency columns
        if has_frequency_column(table_html):
            frequency_table_matches.append(match)
    
    # Find all h4 and h5 elements with their positions
    h4_matches = [(match.start(), re.sub(r'<[^>]+>', '', match.group(1)).strip()) 
                  for match in re.finditer(r'<h4[^>]*>(.*?)</h4>', html_content, re.IGNORECASE | re.DOTALL)
                  if re.sub(r'<[^>]+>', '', match.group(1)).strip() not in ["", "Image"]]
    
    h5_matches = [(match.start(), re.sub(r'<[^>]+>', '', match.group(1)).strip()) 
                  for match in re.finditer(r'<h5[^>]*>(.*?)</h5>', html_content, re.IGNORECASE | re.DOTALL)
                  if re.sub(r'<[^>]+>', '', match.group(1)).strip()]
    
    print(f"Found {len(frequency_table_matches)} frequency tables, {len(h4_matches)} h4 sections, {len(h5_matches)} h5 titles")
    
    sections_and_tables = []
    for table_idx, table_match in enumerate(frequency_table_matches):
        table_pos = table_match.start()
        
        # Find the most recent h4 (section) before this table
        current_section = next((h4_text for h4_pos, h4_text in reversed(h4_matches) if h4_pos < table_pos), "Unknown")
        
        # Find the most recent h5 (table title) after the section but before the table
        section_pos = next((h4_pos for h4_pos, h4_text in reversed(h4_matches) if h4_pos < table_pos and h4_text == current_section), 0)
        table_name = next((h5_text for h5_pos, h5_text in reversed(h5_matches) if section_pos < h5_pos < table_pos), "General")
        
        # Try table caption if no h5 found
        if table_name == "General":
            caption_match = re.search(r'<caption[^>]*>(.*?)</caption>', table_match.group(1), re.IGNORECASE)
            if caption_match:
                caption_text = re.sub(r'<[^>]+>', '', caption_match.group(1)).strip()
                if caption_text and caption_text not in ["", "Frequency", "License", "Type"]:
                    table_name = caption_text
        
        print(f"  Frequency table {table_idx + 1} at position {table_pos}: {current_section} - {table_name}")
        sections_and_tables.append((current_section, table_name))
    
    return sections_and_tables


def grab_local_frequencies(url="https://www.radioreference.com/db/browse/ctid/1855", output_file="local_frequencies.json"):
    """Download and organize local frequency data from RadioReference using simplified parsing."""
    print("Grabbing local frequencies from RadioReference...")
    
    try:
        # Download the webpage
        print(f"Fetching frequency data from {url}...")
        with urllib.request.urlopen(url) as response:
            html_content = response.read().decode('utf-8')
        
        # Extract county name and context
        county_name = extract_county_name_from_html(html_content)
        sections_and_tables = extract_context_from_html(html_content)
        
        # Extract and process tables
        print("Extracting tables from HTML...")
        raw_tables = extract_tables_from_html(html_content)
        print("Identifying frequency tables...")
        frequency_tables = identify_frequency_tables(raw_tables)
        
        if not frequency_tables:
            print("Warning: No frequency tables found")
            return {}
            
        if len(frequency_tables) != len(sections_and_tables):
            print(f"Warning: Mismatch between number of tables ({len(frequency_tables)}) and names ({len(sections_and_tables)})")
        
        # Flatten all frequencies into a single list with metadata
        all_frequencies = []
        for table_idx, table in enumerate(frequency_tables):
            # Get section and table names - use index or fallback
            section, table_name = (sections_and_tables[table_idx] if table_idx < len(sections_and_tables) 
                                 else (f"Section_{table_idx + 1}", f"Table_{table_idx + 1}"))
            
            print(f"  Table {table_idx + 1}: {section} - {table_name} ({len(table)} frequencies)")
            
            for freq_entry in table:
                freq_entry.update({
                    "source_table": table_idx + 1,
                    "source_section": section,
                    "source_table_name": table_name,
                    "source_category": f"{section} - {table_name}"
                })
                all_frequencies.append(freq_entry)
        
        # Create and save JSON structure
        frequency_data = {
            "source": "RadioReference.com",
            "url": url,
            "extracted_date": time.strftime("%Y-%m-%d %H:%M:%S"),
            "county_name": county_name,
            "total_frequencies": len(all_frequencies),
            "sections_and_tables": sections_and_tables,
            "frequencies": all_frequencies
        }
        
        with open(output_file, 'w') as f:
            json.dump(frequency_data, f, indent=2)
            
        print(f"Successfully extracted {len(all_frequencies)} frequencies from {len(frequency_tables)} tables")
        if county_name:
            print(f"County/Area: {county_name}")
        print(f"Frequency data saved to {output_file}")
        
        # Print summary
        print(f"\nSummary:")
        print(f"  Total frequencies: {len(all_frequencies)}")
        print(f"  Sections/Tables found: {len(sections_and_tables)}")
        if sections_and_tables:
            print(f"  Tables: {', '.join([f'{s}-{t}' for s, t in sections_and_tables[:3]])}{'...' if len(sections_and_tables) > 3 else ''}")
            
        return frequency_data
        
    except urllib.error.URLError as e:
        print(f"Error fetching frequency data: {e}")
        return {}
    except Exception as e:
        print(f"Error processing frequency data: {e}")
        return {}


def frequency_to_freqman_format(freq_entry, include_p25e=False):
    """Convert a frequency entry to Freqman format."""
    # Extract frequency and clean it up
    freq_str = freq_entry.get("frequency", "").strip()
    if not freq_str:
        return None
    
    try:
        freq_hz = int(float(freq_str) * 1000000)  # Convert MHz to Hz
    except ValueError:
        return None
    
    # Check mode and handle P25E filtering
    mode = freq_entry.get("mode", "").strip().upper()
    if not include_p25e and mode == "P25E":
        return None
    
    # Build description (max 30 chars) from available fields
    description_parts = [part for part in [
        freq_entry.get("type", "").strip(),
        freq_entry.get("description", "").strip(),
        freq_entry.get("alias", "").strip() if not freq_entry.get("description", "").strip() else "",
        freq_entry.get("source_category", "").strip() if not any([
            freq_entry.get("type", "").strip(),
            freq_entry.get("description", "").strip(),
            freq_entry.get("alias", "").strip()
        ]) else ""
    ] if part]
    
    description = " ".join(description_parts)[:30] if description_parts else "Unknown"
    
    # Determine modulation and bandwidth
    modulation = "NFM" if mode == "FMN" else mode if mode in ["FM", "AM", "NFM", "WFM"] else "FM"
    bandwidth = {"NFM": "12k5", "WFM": "200k", "AM": "12k5"}.get(modulation, "25k")
    
    # Build Freqman entry as single line with comma-separated values
    return f"f={freq_hz},m={modulation},bw={bandwidth},d={description}"


def sanitize_filename(text):
    """Sanitize text for use as filename."""
    # Remove or replace invalid filename characters
    sanitized = re.sub(r'[<>:"/\\|?*]', '_', text)
    # Remove extra spaces and replace with underscores
    sanitized = re.sub(r'\s+', '_', sanitized)
    # Remove leading/trailing underscores and dots
    sanitized = sanitized.strip('_.')
    # Limit length
    return sanitized[:50] if sanitized else "UNKNOWN"


def export_table_to_freqman(frequencies, section, table_name, output_dir=".", max_entries=150, include_p25e=False):
    """Export a single table's frequencies to Freqman format."""
    if not frequencies:
        print(f"  No frequencies for {section} - {table_name}")
        return False
    
    # Create sanitized filename and path
    section_clean = sanitize_filename(section).upper()
    table_clean = sanitize_filename(table_name).upper()
    filename = f"{section_clean}_{table_clean}.txt"
    
    import os
    output_path = os.path.join(output_dir, filename)
    
    # Sort frequencies and convert to Freqman format
    try:
        sorted_frequencies = sorted(frequencies, key=lambda x: float(x.get("frequency", "0")))
    except ValueError:
        sorted_frequencies = frequencies
    
    freqman_entries = [
        f"# {section} - {table_name}",
        f"# Source: RadioReference.com", 
        f"# Extracted: {time.strftime('%Y-%m-%d %H:%M:%S')}",
        f"# Total entries: {len(frequencies)}",
        ""
    ]
    
    successful_conversions = 0
    skipped_p25e = 0
    
    for freq_entry in sorted_frequencies:
        freqman_entry = frequency_to_freqman_format(freq_entry, include_p25e)
        if freqman_entry:
            freqman_entries.append(freqman_entry)
            successful_conversions += 1
        elif not include_p25e and freq_entry.get("mode", "").strip().upper() == "P25E":
            skipped_p25e += 1
    
    # Limit to max entries after filtering
    if successful_conversions > max_entries:
        print(f"  Warning: Limiting {section} - {table_name} to {max_entries} entries (found {successful_conversions})")
        # Keep header lines plus max_entries frequency lines
        total_lines_to_keep = 5 + max_entries  # 5 header lines + frequency entries
        freqman_entries = freqman_entries[:total_lines_to_keep]
        successful_conversions = max_entries
    
    # Write to file
    try:
        with open(output_path, 'w') as f:
            f.write('\n'.join(freqman_entries))
        
        status_msg = f"  Created: {filename} ({successful_conversions} frequencies"
        if skipped_p25e > 0:
            status_msg += f", {skipped_p25e} P25E entries excluded"
        status_msg += ")"
        print(status_msg)
        return True
        
    except Exception as e:
        print(f"  Error creating {filename}: {e}")
        return False


def export_tables_to_freqman(frequency_data, output_dir="freqman_files", include_p25e=False):
    """Export each table to its own Freqman file."""
    print(f"Exporting tables to separate Freqman files in directory: {output_dir}")
    if not include_p25e:
        print("P25E entries will be excluded (use --include-p25e to include them)")
    else:
        print("P25E entries will be included")
    
    if not frequency_data or "frequencies" not in frequency_data:
        print("No frequency data to export")
        return False
    
    # Create output directory
    import os
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created directory: {output_dir}")
    
    frequencies = frequency_data["frequencies"]
    if not frequencies:
        print("No frequencies found in data")
        return False
    
    # Group frequencies by section and table
    table_groups = {}
    for freq_entry in frequencies:
        section = freq_entry.get("source_section", "Unknown")
        table_name = freq_entry.get("source_table_name", "Table")
        key = (section, table_name)
        
        if key not in table_groups:
            table_groups[key] = []
        table_groups[key].append(freq_entry)
    
    print(f"Found {len(table_groups)} unique tables to export:")
    
    successful_files = 0
    for (section, table_name), table_frequencies in table_groups.items():
        if export_table_to_freqman(table_frequencies, section, table_name, output_dir, include_p25e=include_p25e):
            successful_files += 1
    
    print(f"\nSuccessfully created {successful_files} Freqman files in {output_dir}/")
    return successful_files > 0


def extract_county_name_from_html(html_content):
    """Extract county name from h2 tag for folder naming."""
    
    # Look for h2 tags that likely contain county names
    h2_pattern = r'<h2[^>]*>(.*?)</h2>'
    h2_matches = re.findall(h2_pattern, html_content, re.IGNORECASE | re.DOTALL)
    
    for h2_content in h2_matches:
        # Clean up the h2 content
        clean_text = re.sub(r'<[^>]+>', '', h2_content).strip()
        
        # Look for patterns that indicate this is a county/area name
        # Common patterns: "County Name County", "City Name", "Area Name"
        if clean_text and len(clean_text) < 100:  # Reasonable length for a county name
            # Skip generic headings
            if clean_text.lower() not in ["frequency", "frequencies", "radio", "database", "search", "browse"]:
                # This looks like it could be a county/area name
                return clean_text
    
    return None


def format_county_folder_name(county_name):
    """Format county name for folder naming with specific rules."""
    if not county_name:
        return None
    
    # Check if there's a comma in the name
    if ',' in county_name:
        # Split by comma and swap the parts
        parts = [part.strip() for part in county_name.split(',', 1)]
        if len(parts) == 2:
            # Format: "Text after comma" + "Text before comma"
            formatted_name = f"{parts[1]} {parts[0]}"
        else:
            formatted_name = county_name
    else:
        formatted_name = county_name
    
    # Sanitize for filename (remove special chars, replace spaces with underscores)
    sanitized = sanitize_filename(formatted_name)
    
    # Make all caps
    return sanitized.upper()


def main():
    """Main function to run the RadioReference frequency extractor."""
    import sys
    
    # Parse command line arguments
    county_id = "1855"  # Default to NYC area
    include_p25e = False
    output_dir = None  # Will be auto-generated if not specified
    
    i = 1
    while i < len(sys.argv):
        arg = sys.argv[i]
        
        if arg in ["--help", "-h"]:
            print("RadioReference.com Frequency Extractor")
            print("Usage:")
            print("  python3 radioref.py [options] [county_id]")
            print("")
            print("Arguments:")
            print("  county_id        RadioReference county ID (default: 1855 for NYC area)")
            print("")
            print("Options:")
            print("  --include-p25e   Include P25E mode entries in output (excluded by default)")
            print("  --output-dir DIR Specify output directory name (default: auto-generated from county name)")
            print("  --help, -h       Show this help message")
            print("")
            print("Examples:")
            print("  python3 radioref.py 1855                          # NYC area frequencies (no P25E)")
            print("  python3 radioref.py 2675                          # Los Angeles County frequencies (no P25E)") 
            print("  python3 radioref.py --include-p25e 1855           # NYC area, include P25E entries")
            print("  python3 radioref.py --output-dir NYC_FREQS 1855   # NYC area, custom output directory")
            return
        elif arg == "--include-p25e":
            include_p25e = True
        elif arg == "--output-dir":
            if i + 1 < len(sys.argv):
                output_dir = sys.argv[i + 1]
                i += 1  # Skip the next argument since it's the directory name
            else:
                print("Error: --output-dir requires a directory name")
                sys.exit(1)
        elif not arg.startswith("--"):
            county_id = arg
        else:
            print(f"Error: Unknown option {arg}")
            sys.exit(1)
        
        i += 1
    
    # Build URL and prepare
    url = f"https://www.radioreference.com/db/browse/ctid/{county_id}"
    temp_json_file = f"temp_county_{county_id}.json"
    
    print(f"RadioReference Frequency Extractor")
    print(f"County ID: {county_id}")
    print(f"URL: {url}")
    print(f"Mode: {'Including' if include_p25e else 'Excluding'} P25E entries{' (use --include-p25e to include)' if not include_p25e else ''}")
    if output_dir:
        print(f"Output directory: {output_dir} (custom)")
    else:
        print(f"Output directory: Auto-generated from county name")
    print("-" * 50)
    
    # Extract frequencies
    data = grab_local_frequencies(url, temp_json_file)
    
    if data:
        print("\nExtraction completed successfully!")
        
        # Create output directory name based on county name or use custom name
        county_name = data.get("county_name")
        if output_dir:
            freqman_dir = output_dir
        else:
            freqman_dir = (format_county_folder_name(county_name) if county_name 
                          else f"COUNTY_{county_id}") or f"COUNTY_{county_id}"
        
        # Export to separate Freqman files for each table
        print(f"\nExporting to Freqman format...")
        if export_tables_to_freqman(data, freqman_dir, include_p25e=include_p25e):
            print(f"Freqman files created in directory: {freqman_dir}/")
        else:
            print("Failed to create Freqman files")
        
        # Clean up temporary JSON file
        import os
        try:
            os.remove(temp_json_file)
            print(f"Temporary file {temp_json_file} removed")
        except:
            pass
    else:
        print("\nExtraction failed!")
        sys.exit(1)


if __name__ == "__main__":
    main()
