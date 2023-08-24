#!/bin/bash
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=8G
#$ -j y
#$ -l h_rt=48:0:0
#$ -m bea
#$ -t 1-72

CODE_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq #insert your code directory path here (pwd command)
RES_DIR=$CODE_DIR/results/raw_files #change it to desired results directory

echo '=================================='
echo -e "\nLoad modules\n"
module load anaconda3

echo '=================================='
echo -e "\nGet Fasta files\n"

python3 $CODE_DIR/scripts/getFastq.py $CODE_DIR/data/cleaned_data/sra_runs_to_do.txt $RES_DIR
