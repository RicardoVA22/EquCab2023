
#!/bin/bash
#$ -cwd
#$ -pe smp 28
#$ -l h_vmem=12G
#$ -j y
#$ -l h_rt=148:0:0
#$ -m bea

#create directory where to store merged files
CODE_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq

cd $CODE_DIR/results/wgs_data
mkdir merged


DIR=$CODE_DIR/results/wgs_data
DATA=$DIR/sorted/*.bam
DATA_FILTERED=$DIR/sorted/*_minq10_sorted.bam
FILE_OUT=$DIR/merged/ref_merged.bam

#----- load modules ----#
echo '=================================='
echo -e "\nLoad samtools\n"
module load samtools

#----- filter poorly mapped reads----#
echo '=================================='
echo -e "\nRemove reads with quality lower than 10\n"


#----- merge ----#
echo '=================================='
echo -e "\nMerge Files\n"
samtools merge -f --threads 7 $FILE_OUT $DATA_FILTERED


echo '=================================='
echo -e "\nIndex\n"

samtools index $FILE_OUT $FILE_OUT.bai


echo '=================================='
echo -e "\nflagstat\n"

samtools flagstat $FILE_OUT > $DIR/ref_merged'.stat1.txt'

## clean up memory space
cd $DIR
rm -r converted





