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
