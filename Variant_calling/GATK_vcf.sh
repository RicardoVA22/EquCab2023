#!/bin/bash
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=8G
#$ -j y
#$ -l h_rt=1:0:0
#$ -m bea
#$ -t 1-31

# Define input files and directories
REFERENCE=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results/ref_genome/EquCab3.fna


VCF_REF= /data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results/wgs_data/variant_calling/ref_chr2.vcf

INPUT_BAM=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results/wgs_data/merged/ref_merged.bam
OUTPUT_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results/wgs_data/variant_calling

#INPUT_BAM=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results/novel_data/merged/novel_merged.bam
#OUTPUT_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results/novel_data/variant_calling

module load samtools
module load gatk

CHR=$SGE_TASK_ID

OUTPUT_VCF=$OUTPUT_DIR/ref_chr$CHR.vcf


gatk HaplotypeCaller \
 -R $VCF_REF \
 -I $INPUT_BAM \
 -L chr$CHR \
 -O $OUTPUT_VCF \
 --native-pair-hmm-threads 20


