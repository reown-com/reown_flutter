#!/bin/bash

# Script to convert all reown_* dependencies from path-based to version-based (latest from pub.dev) in pubspec.yaml files

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Converting reown_* dependencies from local paths to pub.dev versions...${NC}"
echo ""

# Function to get latest version from pub.dev
get_latest_version() {
  local package_name=$1
  local api_url="https://pub.dev/api/packages/${package_name}"
  
  # Query pub.dev API and extract latest version
  # The API returns JSON with a "latest" object containing "version"
  local version=$(curl -s "$api_url" 2>/dev/null | grep -o '"latest":{[^}]*"version":"[^"]*"' | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
  
  if [ -z "$version" ]; then
    # Fallback: try parsing the JSON more directly
    version=$(curl -s "$api_url" 2>/dev/null | grep -oE '"version":\s*"[0-9]+\.[0-9]+\.[0-9]+[^"]*"' | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+[^"]*' | head -1)
  fi
  
  echo "$version"
}

# Find all pubspec.yaml files (excluding nested packages and build directories)
find . -name "pubspec.yaml" -type f \
  -not -path "*/packages/qr-bar-code-scanner-dialog/*" \
  -not -path "*/build/*" \
  -not -path "*/.dart_tool/*" \
  | while read -r pubspec_file; do
  
  # Skip if file doesn't exist
  [ ! -f "$pubspec_file" ] && continue
  
  # Check if file has any reown_* dependencies with path: ../reown_*/
  if grep -qE "^[[:space:]]*reown_[a-zA-Z0-9_]+:[[:space:]]*$" "$pubspec_file" 2>/dev/null; then
    echo -e "${GREEN}Processing: $pubspec_file${NC}"
    
    # Read file into array to allow look-ahead
    mapfile -t lines < "$pubspec_file"
    
    # Create a temporary file
    temp_file=$(mktemp)
    
    # Process the file line by line
    i=0
    while [ $i -lt ${#lines[@]} ]; do
      line="${lines[$i]}"
      
      # Check if line matches pattern: spaces + reown_*package*: (empty value, meaning next line has path)
      if [[ $line =~ ^([[:space:]]*)(reown_[a-zA-Z0-9_]+):[[:space:]]*$ ]]; then
        # Extract indentation and package name
        indent="${BASH_REMATCH[1]}"
        full_package="${BASH_REMATCH[2]}"
        
        # Check if next line exists and is a path dependency
        if [ $((i + 1)) -lt ${#lines[@]} ]; then
          next_line="${lines[$((i + 1))]}"
          
          if [[ $next_line =~ ^[[:space:]]*path:[[:space:]]*\.\./ ]]; then
            # Get latest version from pub.dev
            echo -e "${YELLOW}  Fetching latest version for ${full_package}...${NC}" >&2
            latest_version=$(get_latest_version "$full_package")
            
            if [ -z "$latest_version" ]; then
              echo -e "${RED}  ⚠ Could not fetch version for ${full_package}, skipping${NC}" >&2
              # Keep original lines
              echo "$line"
              echo "$next_line"
              i=$((i + 2))
              continue
            else
              # Replace with version-based dependency
              echo "${indent}${full_package}: ^${latest_version}"
              echo -e "${YELLOW}  ✓ Converted ${full_package} to ^${latest_version}${NC}" >&2
              i=$((i + 2))
              continue
            fi
          fi
        fi
        
        # Not a path dependency or no next line, keep original line
        echo "$line"
      else
        # Keep the original line
        echo "$line"
      fi
      
      i=$((i + 1))
    done > "$temp_file"
    
    # Replace original file with processed file
    mv "$temp_file" "$pubspec_file"
    echo -e "${YELLOW}  ✓ Updated dependencies in $pubspec_file${NC}"
  fi
done

echo ""
echo -e "${GREEN}Conversion complete!${NC}"

