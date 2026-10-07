#!/bin/bash
#SBATCH --job-name=blast_P68871
#SBATCH --account=hpc2ncourses2026-013
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=blast_P68871_%j.out
#SBATCH --error=blast_P68871_%j.err

module load GCC/14.2.0 OpenMPI/5.0.7 BLAST+/2.17.0

blastp \
  -query P68871_protein.fasta \
  -db /proj/nobackup/cddb_course/databases/swissprot/swissprot \
  -out P68871_blastp_local.txt \
  -outfmt 6 \
  -evalue 1e-5 \
  -num_threads 4 \
  -max_target_seqs 1000

echo "BLAST complete: $(date)"
