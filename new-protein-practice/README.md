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


## Part 3 - BLAST Interpretation

### Question 1 - How many BLAST hits have an E-value below 1e-10?

**Command:**
```bash
awk -F'\t' '$11 < 1e-10' P68871_blastp_local.txt | wc -l
```

**Answer:**

823 BLAST hits have an E-value below 1e-10.

### Question 2 - How many BLAST hits have at least 90% sequence identity?

**Command:**
```bash
awk -F'\t' '$3 >= 90' P68871_blastp_local.txt | wc -l
```

**Answer:**

76 BLAST hits have at least 90% sequence identity.

### Question 3 - Identify the best non-self hit, its identity and organism.

**Commands:**
```bash
awk -F'\t' '$2 != "P68871"' P68871_blastp_local.txt | head -1 | cut -f2,3
curl "https://rest.uniprot.org/uniprotkb/P68873.txt" > P68873_protein.txt
grep "^OS" P68873_protein.txt
```

**Answer:**

- Accession: P68873
- Sequence identity: 100.000%
- Organism: *Pan troglodytes* (Chimpanzee)

The best non-self hit has 100% sequence identity with the query protein.

### Question 4 - Identify the hit with the lowest percentage identity, its E-value and organism.

**Commands:**
```bash
sort -t$'\t' -k3,3g P68871_blastp_local.txt | cut -f2,3,11 | head -1
curl "https://rest.uniprot.org/uniprotkb/P21198.txt" > P21198_protein.txt
grep "^OS" P21198_protein.txt
```

**Answer:**

- Accession: P21198
- Sequence identity: 25.000%
- E-value: 1.34e-10
- Organism: *Mordacia mordax* (Southern hemisphere lamprey)

### Question 5 - Interpret the sequence conservation based on your BLAST results.

**Answer:**

The BLAST results suggest that hemoglobin subunit beta is highly conserved among closely related species. The chimpanzee hit shows 100% sequence identity with the human protein.

Of the 872 BLAST hits, 823 have E-values below 1e-10, indicating statistically strong sequence similarities, while 76 hits have at least 90% sequence identity.

The lowest-identity hit is from the southern hemisphere lamprey, with 25% identity and an E-value of 1.34e-10. This suggests that detectable sequence similarity extends to more distantly related species, although the degree of conservation varies.

Overall, the results support strong sequence conservation among closely related species and detectable similarities in more distantly related organisms.
