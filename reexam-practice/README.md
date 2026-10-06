# Part 1 — Retrieval

## Question 1
Answer: The protein has 148 amino acids.

Command:
grep "^ID\|^SQ" LYZ_protein.txt

## Question 2
Answer: The UniProt entry is Swiss-Prot (Reviewed).

Command:
grep "^ID\|^SQ" LYZ_protein.txt

## Question 3
Answer: The RefSeq mRNA record retrieved was NM_000239.3.

Command:
grep "^DR   RefSeq;" LYZ_protein.txt

## Question 4
Answer:
IDA: 5
TAS: 5
IBA: 2
HDA: 1
IPI: 1

Command:
grep "^DR   GO;" LYZ_protein.txt | cut -d";" -f4 | cut -d: -f1 | sort | uniq -c | sort -k1,1nr

## Question 5
Answer: There are 215 PDB structures:
X-ray: 210
EM: 2
NMR: 2
Neutron: 1

Commands:
grep -c "^DR   PDB;" LYZ_protein.txt

grep "^DR   PDB;" LYZ_protein.txt | cut -d";" -f3 | sort | uniq -c

## Question 6
Answer: The mRNA is 1490 bp long.

Command:
grep "^LOCUS" LYZ_mRNA.gb


# Part 2 — BLAST

## Question 1
Answer: The Slurm job ID was 47586158. The BLAST search returned 152 hits.

Command:
wc -l LYZ_blastp_local.tsv

## Question 2
Answer: The top three BLAST hits were:

P61628  100.000%  5.48e-107
P61627  100.000%  5.48e-107
P61626  100.000%  5.48e-107

Command:
head -3 LYZ_blastp_local.tsv | cut -f2,3,11

## Question 3
Answer: The first five results after sorting by E-value from smallest to largest were:

P61626  100.000  5.48e-107
P61627  100.000  5.48e-107
P61628  100.000  5.48e-107
P79179  99.324   3.54e-106
P79239  97.973   1.63e-105

Command:
sort -t$'\t' -k11,11g LYZ_blastp_local.tsv | cut -f2,3,11 | head -5

The -n option does not correctly handle E-values written in scientific notation.
The -g option performs general numerical sorting and correctly interprets values such as 5.48e-107.
