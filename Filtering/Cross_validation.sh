#!/bin/bash
#$ -cwd
#$ -pe smp 12
#$ -l h_vmem=6G
#$ -j y
#$ -l h_rt=72:0:0
#$ -m bea
#$ -t 1-70

admixture=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/tools/dist/admixture_linux-1.3.0/admixture

FILE=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/tools



$admixture --cv $FILE/ref_chr2_prun_15_PCA.bed $SGE_TASK_ID -j12 > $FILE/log_15th_$SGE_TASK_ID.out
