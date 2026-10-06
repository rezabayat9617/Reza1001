#!/bin/bash
#SBATCH --job-name=blast_LYZ
#SBATCH --account=hpc2ncourses2026-013
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=blast_LYZ_%j.out

module load GCC/14.2.0 OpenMPI/5.0.7 BLAST+/2.17.0

blastp \
-query LYZ_protein.fasta \
-db /proj/nobackup/cddb_course/databases/swissprot/swissprot \
-out LYZ_blastp_local.tsv \
-outfmt 6 \
-evalue 1e-5 \
-max_target_seqs 1000 \
-num_threads 4
