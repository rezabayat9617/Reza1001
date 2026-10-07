# Practical Re-exam Practice

Assigned UniProt accession: P68871

## Part 1 - Retrieval and database queries

### Question 1 - How many amino acids long is the protein?

Command:
grep "^ID\|^SQ" P68871_protein.txt

Answer:
The protein is 147 amino acids long.

### Question 2 - Is the protein entry Swiss-Prot or TrEMBL?

Command:
grep "^ID\|^SQ" P68871_protein.txt

Answer:
The protein entry is Swiss-Prot (Reviewed).

### Question 3 - Which RefSeq mRNA corresponds to the protein?

Command:
grep "^DR   RefSeq;" P68871_protein.txt

Answer:
The RefSeq mRNA accession is NM_000518.5.

### Question 4 - How many GO annotations are there for each evidence code?

Command:
grep "^DR   GO;" P68871_protein.txt | cut -d";" -f4 | cut -d: -f1 | sort | uniq -c | sort -k1,1nr

Answer:
IDA: 10
IBA: 4
TAS: 4
HDA: 2
NAS: 2
HMP: 1
IEA: 1
IMP: 1

### Question 5 - How many PDB structures are there and how many use each experimental method?

Command:
grep "^DR   PDB;" P68871_protein.txt | cut -d";" -f3 | sort | uniq -c

Answer:
There are 348 PDB structures in total:
X-ray: 304
EM: 40
Neutron: 2
NMR: 2

### Question 6 - How long is the mRNA in bp according to the GenBank record?

Command:
grep "^LOCUS" P68871_mRNA.gb

Answer:
The RefSeq mRNA is 628 bp long.


## Part 2 - Local BLAST via Slurm

### Question 1 - Slurm job ID and number of BLAST hits

**Commands:**
```bash
sbatch blast_P68871.sh
squeue -u $USER
wc -l P68871_blastp_local.txt
```

**Answer:**

Slurm Job ID: 47607489

Total BLAST hits: 872

BLAST was run against the local Swiss-Prot database using `-outfmt 6`, `-evalue 1e-5`, and `-max_target_seqs 1000`.

### Question 2 - Top 3 BLAST hits with E-values and percentage identities

**Command:**
```bash
cut -f2,3,11 P68871_blastp_local.txt | head -3
```

**Answer:**

| Accession | Identity (%) | E-value |
|---|---|---|
| P68873 | 100.000 | 6.56e-106 |
| P68872 | 100.000 | 6.56e-106 |
| P68871 | 100.000 | 6.56e-106 |

All three hits have 100% sequence identity and the same E-value.

### Question 3 - Sort BLAST hits by E-value (smallest first)

**Command:**
```bash
sort -t$'\t' -k11,11g P68871_blastp_local.txt | cut -f2,11 | head -5
```

**Answer:**

| Accession | E-value |
|---|---|
| P68871 | 6.56e-106 |
| P68872 | 6.56e-106 |
| P68873 | 6.56e-106 |
| P02024 | 2.29e-105 |
| P02025 | 3.34e-103 |

**Explanation:**

The `-g` option correctly sorts E-values written in scientific notation, such as `6.56e-106`. The `-n` option does not correctly interpret the exponent, so `sort -k11 -n` is not suitable for sorting BLAST E-values.

The first three hits have identical E-values, so their relative order can change during sorting.
