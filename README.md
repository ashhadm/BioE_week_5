# BioE_week_5

## Count number of amino acids and bases in ORF of the DNA sequence encoding the given amino acid sequence

```python
aa_sequence = "KVRMFTSELDIMLSVNG-PADQIKYFCRHWT*"

# Remove the gap '-' from the sequence
aa_sequence_no_gap = aa_sequence.replace("-", "")

# Count the number of amino acids (excluding stop codon)
num_amino_acids = len(aa_sequence_no_gap) - 1  # -1 to exclude stop codon

# Calculate the number of bases in the open reading frame
num_bases = (num_amino_acids + 1) * 3  # +1 to include stop codon

print(f"Number of amino acids: {num_amino_acids}")
print(f"Number of bases in the open reading frame: {num_bases}")

# Output
# Number of amino acids: 30
# Number of bases in the open reading frame: 93
```

## Running Prodigal on a genome to count number of genes

```bash
module load prodigal
prodigal -i e.coli.fna -o e.coli.gbk -d e.coli_genes.fna
grep ">" e.coli_genes.fna -c > gene_count.txt
```
## Script to run Prodigal on all downloaded genomes

```bash
touch myscript.sh
nano myscript.sh
chmod +x myscript.sh
sbatch myscript.sh

# output - prodigal_results.txt
```

## Annotate all genomes using prokka

```bash
touch my_prokka.sh
nano my_prokka.sh
chmod +x my_prokka.sh
sbatch my_prokka.sh
```
