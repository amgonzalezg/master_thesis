#!/bin/bash

# Define the directory path
DIRECTORIES=("sequences_search_fragmented" "sequences_search_multi_copy" "sequences_search_copy_single")

# Input file with the BUSCO IDs
INPUT_FILE="search_ids.txt"

# Output file with the list of IDs and their classifications
OUTPUT_FILE="search_list.txt"

# Create the output file and add headers
echo -e "LOOKUP_ID\tClassification" > "$OUTPUT_FILE"

# Read each LOOKING ID from the input file and look for them in the directories
while reading -r LOOKUP_ID; do
      # Variable to store the classification
      rating="Missing"

      # Check if the ID is in any of the folders
      for directory in "${DIRECTORIES[@]}"; do
          if [ -f "$dir/${LOOKUP_ID}.faa" ] || [ -f "$dir/${LOOKUP_ID}.fna" ] || [ -f "$dir/${LOOKUP_ID}.gff" ]; so
              rank="$dir"
              break
          fi
      made

      # Add a line to the output file with the BUSCO_ID and its classification
      echo -e "$LOOKUP_ID\t$sort" >> "$OUTPUT_FILE"
done < "$INPUT_FILE"