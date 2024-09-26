#!/bin/bash
#SBATCH--job-name=ash_script
#SBATCH--output=ash_prokka.out
#SBATCH--error=ash_prokka.err
#SBATCH--time=1:00:00

# Output file for results
RESULTS_FILE="/home/ashhadm/prokka_results.txt"

# Clear the results file if it exists
> "$RESULTS_FILE"

# Process each genome file
for genome in $(find /home/ashhadm/in_class/genomes -type f -name "*GCF*.fna"); do
    # Get the base name of the genome file
    base_name=$(basename "$genome" .fna)
    
    # Create a directory for Prokka output
    output_dir="${base_name}_prokka"
    
    # Run Prokka
    prokka --outdir "$output_dir" --prefix "$base_name" "$genome" --quiet

    # Count CDS
    cds_count=$(grep -c "CDS" "$output_dir/${base_name}.gff")

    # Save the result
    echo "Genome: $genome" >> "$RESULTS_FILE"
    echo "CDS count: $cds_count" >> "$RESULTS_FILE"
    echo "" >> "$RESULTS_FILE"

    # Print progress
    echo "Processed $genome: $cds_count CDS"
done

echo "Results have been saved to $RESULTS_FILE"

# Find the genome with the highest CDS count
max_cds=$(sort -k4 -n "$RESULTS_FILE" | tail -n3 | head -n1)
echo -e "\nGenome with the highest number of CDS:\n$max_cds"

