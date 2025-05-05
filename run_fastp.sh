#!/bin/bash

# Directory where the FastQ files are located
input_dir="."  # Change to your directory if it's different

# Output directory for trimmed files and reports
output_dir="./fastp_output"
mkdir -p "$output_dir"

# Loop through all *_1.fastq files (paired-end reads)
for fq1 in $input_dir/*_1.fastq; do
  # Define the corresponding *_2.fastq file
  fq2="${fq1/_1.fastq/_2.fastq}"

  # Check if the paired file exists
  if [ -f "$fq2" ]; then
    # Extract the base name for output files (e.g., SRR1027171)
    base_name=$(basename "$fq1" "_1.fastq")

    # Define output filenames
    trimmed_fq1="$output_dir/${base_name}_1_trimmed.fastq"
    trimmed_fq2="$output_dir/${base_name}_2_trimmed.fastq"
    fastp_report="$output_dir/${base_name}_fastp_report.html"

    # Run fastp for the paired files
    fastp -i "$fq1" -I "$fq2" -o "$trimmed_fq1" -O "$trimmed_fq2" -h "$fastp_report"

    echo "Processed: $fq1 and $fq2"
  else
    echo "Warning: No pair file found for $fq1"
  fi
done

echo "fastp processing completed for all samples."

