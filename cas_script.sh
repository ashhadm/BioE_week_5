#!/bin/bash

# Directory containing the genome files
genome_dir="/home/ashhadm/Downloads/in_class/genomes"

# Output file
output_file="crispr_results.tsv"

# Clear the output file if it exists
> "$output_file"

# Find all .fna files and process them
find "$genome_dir" -type f -name "*GCF*.fna" | while read -r genome_file; do
    # Extract species name from the first line of the file
    species=$(head -n 1 "$genome_file" | sed 's/^>//' | rev | cut -d' ' -f3- | rev)
    
    # Run CRISPRCasFinder
    perl CRISPRCasFinder.pl -in "$genome_file" -cas -keep -quiet
    
    # Get the name of the most recently created directory (CRISPRCasFinder output)
    output_dir=$(ls -dt Result_*/ | head -n 1)
    
    # Check if rawCRISPRs.fna exists in the main output directory and count CRISPR arrays
    if [ -f "${output_dir}rawCRISPRs.fna" ]; then
        crispr_count=$(grep -c "^>" "${output_dir}rawCRISPRs.fna")
    else
        crispr_count=0
    fi
    
    # Append results to the output file
    echo -e "${species}\t${crispr_count}" >> "$output_file"
    
    echo "Processed: $species"
    
    # Clean up output directory
    #rm -rf "$output_dir"
done

echo "Results saved in $output_file"
