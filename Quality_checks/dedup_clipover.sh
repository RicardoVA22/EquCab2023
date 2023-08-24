#!/bin/bash
#$ -cwd
#$ -pe smp 20
#$ -l h_vmem=12G
#$ -j y
#$ -l h_rt=200:0:0
#$ -m bea

#create directory where to store merged files
CODE_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq

DIR=$CODE_DIR/results/wgs_data
DATA=$DIR/sorted/*.bam
DATA_FILTERED=$DIR/sorted/*_minq10_sorted.bam
FILE_OUT=$DIR/merged/ref_merged.bam
WGS_DATA=$CODE_DIR/results/wgs_data

echo -e "\nLoad samtools etc\n"
module load samtools # general
module load java # picard associated
module load anaconda3
PICARD=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/tools/picard.jar #where Picard jarfile


PATH_TO_FILE=$FILE_OUT
#samtools view -h -q 10 $PATH_TO_FILE | samtools view -buS - | samtools sort -o $DIR/merged/ref_merge_minq10.bam

java -Xmx60g -jar $PICARD MarkDuplicates \
  I=$PATH_TO_FILE \
  O=$DIR/merged/ref_merge_dedup.bam \
  M=$WGS_DATA/stats/ref_merge_dedup.txt \
  REMOVE_DUPLICATES=true

##remove minq10 files to free memory
#rm $DIR/merged/ref_merge_minq10.bam

bam clipOverlap --in $DIR/merged/ref_merge_dedup.bam --out $DIR/merged/merged_dedup_overlapclipped.bam --stats

#rm $DIR/merged/ref_merge_dedup.bam

samtools index $DIR/merged/ref_merge_dedup_overlapclipped.bam $DIR/merged/ref_merge_dedup_overlapclipped.bam.bai

echo '=================================='
echo -e "\nCalculating average depth of bam filen"

samtools depth -a $DIR/ref_merge_dedup_overlapclipped.bam | awk '{c++;s+=$3}END{print s/c}' > $WGS_DATA/depth/ref_merge_dedup_overlapclipped_depth.txt




