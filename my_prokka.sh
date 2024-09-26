#!/bin/bash
#SBATCH--job-name=ash_script
#SBATCH--output=ash_prokka.out
#SBATCH--error=ash_prokka.err
#SBATCH--time=1:00:00

RESULTS_FILE="/home/ashhadm/prokka_results.txt"

for genome in $(find /home/ashhadm/in_class/genomes -type f -name "*GCF*.fna"); do

    base_name=$(basename "$genome" .fna)
    output_dir="${base_name}_prokka"
    
    prokka --outdir "$output_dir" --prefix "$base_name" "$genome" --quiet

    cds_count=$(grep -c "CDS" "$output_dir/${base_name}.gff")

    echo "Genome: $genome" >> "$RESULTS_FILE"
    echo "CDS count: $cds_count" >> "$RESULTS_FILE"
    echo "" >> "$RESULTS_FILE"

    echo "Processed $genome: $cds_count CDS"
done

echo "Results have been saved to $RESULTS_FILE"

max_cds=$(sort -k4 -n "$RESULTS_FILE" | tail -n3 | head -n1)
echo -e "\nGenome with the highest number of CDS:\n$max_cds"

