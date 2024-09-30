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

# output - prodigal_results.txt & all_genome_counts_prodigal.txt
```

## Annotate all genomes using prokka and check differences

```bash
touch my_prokka.sh
nano my_prokka.sh
chmod +x my_prokka.sh
sbatch my_prokka.sh

# output - prokka_results.txt
```

## Extract list of all unique gene names

```bash
grep -h "gene=" */GCF*.gff | sed 's/.*gene=//; s/;.*//' | sort -u > unique_gene_names.txt
head -n 5 unique_gene_names.txt
```
![image](https://github.com/user-attachments/assets/c31a1002-6ee4-4207-9cfb-60a790dfd7b0)

## Extracting CRISPR sequences

Full results can be found at: [Drive Link](https://drive.google.com/drive/folders/10ZARff8yfctWOikBWkoREE9Lg--p7nhn?usp=drive_link)

```bash
conda env create -f ccf.environment.yml -n crisprcasfinder
conda activate crisprcasfinder
mamba init
mamba activate
mamba install -c bioconda macsyfinder=2.1.2
macsydata install -u CASFinder==3.1.0

touch cas_script.sh
chmod +x cas_script.sh
./cas_script.sh

# Output: crispr_results.tsv
```
