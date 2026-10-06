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



# Part 3 — Interpretation

## Question 1
Answer: 150 hits have an E-value below 1e-10.
Command:
awk -F'\t' '$11 < 1e-10' LYZ_blastp_local.tsv | wc -l

## Question 2
Answer: 6 hits have at least 90% identity.
Command:
awk -F'\t' '$3 >= 90' LYZ_blastp_local.tsv | wc -l

## Question 3
Answer: The best non-self hit is P61628 with 100.000% identity. The organism is Pan troglodytes (Chimpanzee).
Commands:
awk -F'\t' '$2 != "P61626"' LYZ_blastp_local.tsv | head -1 | cut -f2,3
curl -s "https://rest.uniprot.org/uniprotkb/P61628.txt" > P61628.txt
grep "^OS" P61628.txt

## Question 4
Answer: The hit with the lowest percentage identity is Q06655 with 32.773% identity and an E-value of 1.37e-16. The protein is Alpha-lactalbumin from Notamacropus eugenii (Tammar wallaby).
Commands:
sort -t$'\t' -k3,3g LYZ_blastp_local.tsv | cut -f2,3,11 | head -1
curl -s "https://rest.uniprot.org/uniprotkb/Q06655.txt" > Q06655.txt
grep "^DE   RecName: Full=" Q06655.txt
grep "^OS" Q06655.txt

## Question 5
Answer: The protein is highly conserved among its closest homologues, with 6 hits having at least 90% identity and the best non-self hit showing 100% identity. In addition, 150 of 152 hits have E-values below 1e-10. The lowest-identity significant hit has 32.773% identity with an E-value of 1.37e-16, showing that detectable sequence similarity also extends to more distant proteins.
