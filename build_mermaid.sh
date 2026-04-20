#!/bin/bash

INPUT_DIR="./docs/mermaid_graphs"
OUTPUT_DIR="./docs/images"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop over all .mmd files in the input directory
for f in "$INPUT_DIR"/*.mmd; do
    # Skip loop if no files match
    [ -e "$f" ] || continue

    filename=$(basename "$f")
    echo "Rendering $filename"

    mmdc -i "$f" -o "$OUTPUT_DIR/${filename%.mmd}.png" -b transparent \
	    -p ./.mermaid-puppeteer.json
done

echo "Done."
