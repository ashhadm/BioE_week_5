#!/bin/bash

genome_dir="/home/ashhadm/Downloads/in_class/genomes"

# Output file
output_file="crispr_results.tsv"

> "$output_file"

find "$genome_dir" -type f -name "*GCF*.fna" | while read -r genome_file; do
   
    species=$(head -n 1 "$genome_file" | sed 's/^>//' | rev | cut -d' ' -f3- | rev)
    
    perl CRISPRCasFinder.pl -in "$genome_file" -cas -keep -quiet
    
    output_dir=$(ls -dt Result_*/ | head -n 1)
    
    if [ -f "${output_dir}rawCRISPRs.fna" ]; then
        crispr_count=$(grep -c "^>" "${output_dir}rawCRISPRs.fna")
    else
        crispr_count=0
    fi
    
    echo -e "${species}\t${crispr_count}" >> "$output_file"
    
    echo "Processed: $species"
    
    #rm -rf "$output_dir"
done

echo "Results saved in $output_file"
