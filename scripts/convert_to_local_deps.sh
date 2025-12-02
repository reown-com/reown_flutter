#!/bin/bash

# Script to convert all reown_* dependencies from version-based to path-based in pubspec.yaml files

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Converting reown_* dependencies to local paths...${NC}"
echo ""

# Find all pubspec.yaml files (excluding nested packages and build directories)
find . -name "pubspec.yaml" -type f \
  -not -path "*/packages/qr-bar-code-scanner-dialog/*" \
  -not -path "*/build/*" \
  -not -path "*/.dart_tool/*" \
  | while read -r pubspec_file; do
  
  # Skip if file doesn't exist
  [ ! -f "$pubspec_file" ] && continue
  
  # Check if file has any reown_* dependencies with version constraints (^ followed by numbers)
  if grep -qE "^[[:space:]]*reown_[a-zA-Z0-9_]+:[[:space:]]*\^" "$pubspec_file" 2>/dev/null; then
    echo -e "${GREEN}Processing: $pubspec_file${NC}"
    
    # Create a temporary file
    temp_file=$(mktemp)
    
    # Process the file line by line
    while IFS= read -r line || [ -n "$line" ]; do
      # Check if line matches pattern: spaces + reown_*package*: ^version
      if [[ $line =~ ^([[:space:]]*)(reown_[a-zA-Z0-9_]+):[[:space:]]*\^[0-9] ]]; then
        # Extract indentation and package name
        indent="${BASH_REMATCH[1]}"
        full_package="${BASH_REMATCH[2]}"
        
        # Replace with path-based dependency
        echo "${indent}${full_package}:"
        echo "${indent}  path: ../${full_package}/"
      else
        # Keep the original line
        echo "$line"
      fi
    done < "$pubspec_file" > "$temp_file"
    
    # Replace original file with processed file
    mv "$temp_file" "$pubspec_file"
    echo -e "${YELLOW}  ✓ Converted dependencies in $pubspec_file${NC}"
  fi
done

echo ""
echo -e "${GREEN}Conversion complete!${NC}"

