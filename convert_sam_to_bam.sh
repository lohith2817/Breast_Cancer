#!/bin/bash

# Define directories
SAM_DIR="hisat2_aligned"
BAM_DIR="bam files"

# Create BAM directory if it doesn't exist
mkdir -p "$BAM_DIR"

# Loop through all .sam files in SAM_DIR
for sam_file in "$SAM_DIR"/*.sam; do
    # Extract base name (e.g., SRR1027171)
    base_name=$(basename "$sam_file" .sam)

    # Convert SAM to BAM
    samtools view -Sb "$sam_file" > "$BAM_DIR/$base_name.bam"
done

echo "All SAM files have been converted to BAM and saved in '$BAM_DIR'"

