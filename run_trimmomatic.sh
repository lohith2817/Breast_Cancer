#!/bin/bash

# Set the correct Trimmomatic JAR and adapters file paths
TRIMMOMATIC_JAR="/Users/lohithbj/miniconda3/envs/metagenomics/share/trimmomatic-0.39-2/trimmomatic.jar"
ADAPTERS="/Users/lohithbj/miniconda3/envs/metagenomics/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa"
OUT_DIR="trimmed_reads"

# Create output directory if it doesn't exist
mkdir -p $OUT_DIR

# Loop through all *_1.fastq files to find pairs
for R1 in *_1.fastq; do
    SAMPLE=$(basename "$R1" _1.fastq)
    R2="${SAMPLE}_2.fastq"

    # Output file paths
    P1="$OUT_DIR/${SAMPLE}_1_paired.fastq.gz"
    U1="$OUT_DIR/${SAMPLE}_1_unpaired.fastq.gz"
    P2="$OUT_DIR/${SAMPLE}_2_paired.fastq.gz"
    U2="$OUT_DIR/${SAMPLE}_2_unpaired.fastq.gz"

    echo "Trimming sample: $SAMPLE"

    java -jar "$TRIMMOMATIC_JAR" PE -phred33 \
        "$R1" "$R2" \
        "$P1" "$U1" "$P2" "$U2" \
        ILLUMINACLIP:"$ADAPTERS":2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

    echo "Finished trimming: $SAMPLE"
done


