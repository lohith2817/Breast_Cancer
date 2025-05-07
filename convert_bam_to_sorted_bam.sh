mkdir -p sorted_bam

for bam in *.bam; do
    base=$(basename "$bam" .bam)
    samtools sort "$bam" -o "sorted_bam/${base}_sorted.bam"
done

