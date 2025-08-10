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


def extract_tables_from_html(html_content):
    """Extract table data from HTML using regex patterns - simpler than full HTML parsing."""
    
    # Find all table sections with regex
    table_pattern = r'<table[^>]*>(.*?)</table>'
    tables = re.findall(table_pattern, html_content, re.DOTALL | re.IGNORECASE)
    
    extracted_tables = []
    
    for table_html in tables:
        # Check if this table has a "Frequency" column by looking at thead
        has_frequency_column = False
        
        # Look for thead section first
        thead_match = re.search(r'<thead[^>]*>(.*?)</thead>', table_html, re.DOTALL | re.IGNORECASE)
        if thead_match:
            thead_content = thead_match.group(1)
            # Check if thead contains "frequency" 
            if "frequency" in thead_content.lower():
                has_frequency_column = True
        
        # If no thead, check th tags directly
        if not has_frequency_column:
            th_pattern = r'<th[^>]*>(.*?)</th>'
            th_matches = re.findall(th_pattern, table_html, re.IGNORECASE)
            for th_content in th_matches:
                clean_th = re.sub(r'<[^>]+>', '', th_content).strip().lower()
                if "frequency" in clean_th:
                    has_frequency_column = True
                    break
        
        # Skip tables without frequency column
        if not has_frequency_column:
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
    """Identify which tables contain frequency data and extract relevant info."""
    frequency_tables = []
    
    for table in tables:
        if not table:
            continue
            
        # Convert to structured data
        structured_data = []
        for row in table:
            if not row:
                continue
                
            # Look for frequency in first column
            if row and re.match(r'^\d{2,3}\.\d+', row[0].strip()):
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
        
        # Check if this table has a "Frequency" column
        has_frequency_column = False
        
        # Look for thead section first
        thead_match = re.search(r'<thead[^>]*>(.*?)</thead>', table_html, re.DOTALL | re.IGNORECASE)
        if thead_match:
            thead_content = thead_match.group(1)
            if "frequency" in thead_content.lower():
                has_frequency_column = True
        
        # If no thead, check th tags directly
        if not has_frequency_column:
            th_pattern = r'<th[^>]*>(.*?)</th>'
            th_matches = re.findall(th_pattern, table_html, re.IGNORECASE)
            for th_content in th_matches:
                clean_th = re.sub(r'<[^>]+>', '', th_content).strip().lower()
                if "frequency" in clean_th:
                    has_frequency_column = True
                    break
        
        # Only include tables with frequency columns
        if has_frequency_column:
            frequency_table_matches.append(match)
    
    # Find all h4 and h5 elements with their positions
    h4_matches = [(match.start(), re.sub(r'<[^>]+>', '', match.group(1)).strip()) 
                  for match in re.finditer(r'<h4[^>]*>(.*?)</h4>', html_content, re.IGNORECASE | re.DOTALL)
                  if re.sub(r'<[^>]+>', '', match.group(1)).strip() not in ["", "Image"]]
    
    h5_matches = [(match.start(), re.sub(r'<[^>]+>', '', match.group(1)).strip()) 
                  for match in re.finditer(r'<h5[^>]*>(.*?)</h5>', html_content, re.IGNORECASE | re.DOTALL)
                  if re.sub(r'<[^>]+>', '', match.group(1)).strip()]
    
    sections_and_tables = []
    
    print(f"Found {len(frequency_table_matches)} frequency tables, {len(h4_matches)} h4 sections, {len(h5_matches)} h5 titles")
    
    for table_idx, table_match in enumerate(frequency_table_matches):
        table_pos = table_match.start()
        
        # Find the most recent h4 (section) before this table
        current_section = "Unknown"
        for h4_pos, h4_text in reversed(h4_matches):
            if h4_pos < table_pos:
                current_section = h4_text
                break
        
        # Find the most recent h5 (table title) before this table
        # but after the current section
        table_name = "General"
        section_pos = 0
        for h4_pos, h4_text in reversed(h4_matches):
            if h4_pos < table_pos and h4_text == current_section:
                section_pos = h4_pos
                break
        
        # Look for h5 between the section and the table
        for h5_pos, h5_text in reversed(h5_matches):
            if section_pos < h5_pos < table_pos:
                table_name = h5_text
                break
        
        # If still no table name, try looking for caption in the table
        if table_name == "General":
            table_html = table_match.group(1)
            caption_match = re.search(r'<caption[^>]*>(.*?)</caption>', table_html, re.IGNORECASE)
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
        
        # Extract county name from h2 tag
        county_name = extract_county_name_from_html(html_content)
        
        # Extract tables using regex (simpler than HTML parsing)
        print("Extracting tables from HTML...")
        raw_tables = extract_tables_from_html(html_content)
        
        # Identify and structure frequency tables
        print("Identifying frequency tables...")
        frequency_tables = identify_frequency_tables(raw_tables)
        
        # Extract category context with proper table-to-name matching
        sections_and_tables = extract_context_from_html(html_content)
        
        if not frequency_tables:
            print("Warning: No frequency tables found")
            return {}
            
        if len(frequency_tables) != len(sections_and_tables):
            print(f"Warning: Mismatch between number of tables ({len(frequency_tables)}) and names ({len(sections_and_tables)})")
        
        # Flatten all frequencies into a single list with metadata
        all_frequencies = []
        
        for table_idx, table in enumerate(frequency_tables):
            # Get section and table names - use index or fallback
            if table_idx < len(sections_and_tables):
                section, table_name = sections_and_tables[table_idx]
            else:
                section = f"Section_{table_idx + 1}"
                table_name = f"Table_{table_idx + 1}"
            
            print(f"  Table {table_idx + 1}: {section} - {table_name} ({len(table)} frequencies)")
            
            for freq_entry in table:
                freq_entry["source_table"] = table_idx + 1
                freq_entry["source_section"] = section
                freq_entry["source_table_name"] = table_name
                freq_entry["source_category"] = f"{section} - {table_name}"
                all_frequencies.append(freq_entry)
        
        # Convert to JSON structure
        frequency_data = {
            "source": "RadioReference.com",
            "url": url,
            "extracted_date": time.strftime("%Y-%m-%d %H:%M:%S"),
            "county_name": county_name,
            "total_frequencies": len(all_frequencies),
            "sections_and_tables": sections_and_tables,
            "frequencies": all_frequencies
        }
        
        # Save the frequency data to a JSON file
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
    
    # Convert frequency from MHz to Hz for Freqman format
    try:
        freq_mhz = float(freq_str)
        freq_hz = int(freq_mhz * 1000000)
    except ValueError:
        return None
    
    # Check mode and handle P25E filtering
    mode = freq_entry.get("mode", "").strip().upper()
    
    # Skip P25E entries unless include flag is set
    if not include_p25e and mode == "P25E":
        return None
    
    # Build description (max 30 chars)
    description_parts = []
    
    # Add type if available
    freq_type = freq_entry.get("type", "").strip()
    if freq_type:
        description_parts.append(freq_type)
    
    # Add description if available
    desc = freq_entry.get("description", "").strip()
    if desc:
        description_parts.append(desc)
    
    # Add alias if available and no other description
    if not description_parts:
        alias = freq_entry.get("alias", "").strip()
        if alias:
            description_parts.append(alias)
    
    # Add category if no other description
    if not description_parts:
        category = freq_entry.get("source_category", "").strip()
        if category:
            description_parts.append(category)
    
    # Combine and truncate description
    description = " ".join(description_parts)[:30] if description_parts else "Unknown"
    
    # Determine modulation based on mode
    if mode == "FMN":
        modulation = "NFM"
    elif mode in ["FM", "AM", "NFM", "WFM"]:
        modulation = mode
    else:
        modulation = "FM"  # Default for most public safety frequencies
    
    # Set bandwidth based on modulation
    if modulation == "NFM":
        bandwidth = "12k5"
    elif modulation == "WFM":
        bandwidth = "200k"
    elif modulation == "AM":
        bandwidth = "12k5"
    else:  # FM
        bandwidth = "25k"
    
    # Set step - common for public safety
    step = "12k5"
    
    # Build Freqman entry
    freqman_entry = f"f={freq_hz}\n"
    freqman_entry += f"m={modulation}\n"
    freqman_entry += f"bw={bandwidth}\n"
    freqman_entry += f"s={step}\n"
    freqman_entry += f"d={description}\n"
    
    return freqman_entry


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
    
    # Create sanitized filename
    section_clean = sanitize_filename(section).upper()
    table_clean = sanitize_filename(table_name).upper()
    filename = f"{section_clean}_{table_clean}.txt"
    
    # Create full path
    import os
    output_path = os.path.join(output_dir, filename)
    
    if not frequencies:
        print(f"  No frequencies for {section} - {table_name}")
        return False
    
    # Sort frequencies by frequency value
    try:
        sorted_frequencies = sorted(frequencies, key=lambda x: float(x.get("frequency", "0")))
    except ValueError:
        sorted_frequencies = frequencies
    
    freqman_entries = []
    successful_conversions = 0
    skipped_p25e = 0
    
    # Add header comment
    freqman_entries.append(f"# {section} - {table_name}")
    freqman_entries.append(f"# Source: RadioReference.com")
    freqman_entries.append(f"# Extracted: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    freqman_entries.append(f"# Total entries: {len(frequencies)}")
    freqman_entries.append("")
    
    for freq_entry in sorted_frequencies:
        # Convert frequency entry
        freqman_entry = frequency_to_freqman_format(freq_entry, include_p25e)
        if freqman_entry:
            freqman_entries.append(freqman_entry)
            successful_conversions += 1
        elif not include_p25e and freq_entry.get("mode", "").strip().upper() == "P25E":
            skipped_p25e += 1
    
    # Limit to max entries after filtering
    if successful_conversions > max_entries:
        print(f"  Warning: Limiting {section} - {table_name} to {max_entries} entries (found {successful_conversions})")
        # Keep header and trim entries
        header_lines = 5  # Number of header comment lines
        total_lines_to_keep = header_lines + (max_entries * 6)  # 6 lines per entry (f, m, bw, s, d, blank)
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
    
    # Default to NYC area if no county ID provided
    default_county_id = "1855"  # NYC area
    county_id = default_county_id
    include_p25e = False
    
    # Parse command line arguments
    if len(sys.argv) > 1:
        if sys.argv[1] == "--help" or sys.argv[1] == "-h":
            print("RadioReference.com Frequency Extractor")
            print("Usage:")
            print("  python3 radioref.py [options] [county_id]")
            print("")
            print("Arguments:")
            print("  county_id        RadioReference county ID (default: 1855 for NYC area)")
            print("")
            print("Options:")
            print("  --include-p25e   Include P25E mode entries in output (excluded by default)")
            print("  --help, -h       Show this help message")
            print("")
            print("Examples:")
            print("  python3 radioref.py 1855                    # NYC area frequencies (no P25E)")
            print("  python3 radioref.py 2675                    # Los Angeles County frequencies (no P25E)") 
            print("  python3 radioref.py --include-p25e 1855     # NYC area, include P25E entries")
            return
        elif sys.argv[1] == "--include-p25e":
            include_p25e = True
            if len(sys.argv) > 2:
                county_id = sys.argv[2]
        else:
            county_id = sys.argv[1]
    
    # Build URL from county ID
    url = f"https://www.radioreference.com/db/browse/ctid/{county_id}"
    
    # Use temporary JSON file that we'll delete
    temp_json_file = f"temp_county_{county_id}.json"
    
    print(f"RadioReference Frequency Extractor")
    print(f"County ID: {county_id}")
    print(f"URL: {url}")
    if include_p25e:
        print("Mode: Including P25E entries")
    else:
        print("Mode: Excluding P25E entries (use --include-p25e to include)")
    print("-" * 50)
    
    # Extract frequencies
    data = grab_local_frequencies(url, temp_json_file)
    
    if data:
        print("\nExtraction completed successfully!")
        
        # Create output directory name based on county name or fallback to ID
        county_name = data.get("county_name")
        if county_name:
            # Format county name for folder name using specific rules
            formatted_folder_name = format_county_folder_name(county_name)
            freqman_dir = formatted_folder_name if formatted_folder_name else f"COUNTY_{county_id}"
        else:
            # Fallback to county ID if no name found
            freqman_dir = f"COUNTY_{county_id}"
        
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
