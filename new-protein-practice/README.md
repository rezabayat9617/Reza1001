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
