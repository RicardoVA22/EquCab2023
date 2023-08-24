#!/bin/bash
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=8G
#$ -j y
#$ -l h_rt=36:0:0
#$ -m bea

# Set the directory containing your sequence files
CODE_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq

# Set the directory where you want to store the FASTQC output
RES_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results

# Specify the path to Trimmmomatic
TRIMMOMATIC_PATH=$CODE_DIR/tools/trimmomatic.jar

# Set your file prefix (customize as needed)
FILE_PREFIX="....... files that need trimming......."

echo -e "\nTrimming\n"

FILE_1=$RES_DIR/trimmed/$FILE_PREFIX'_1.trim.fq'
FILE_2=$RES_DIR/trimmed/$FILE_PREFIX'_2.trim.fq'

echo 'read 1'
java -jar $TRIMMOMATIC_PATH PE -threads 8 \
    $RES_DIR/raw_files/$FILE_PREFIX'_1.fq' $RES_DIR/raw_files/$FILE_PREFIX'_2.fq' \
    $FILE_1 $RES_DIR/unpaired/$FILE_PREFIX'_1.unpaired.fq' \
    $FILE_2 $RES_DIR/unpaired/$FILE_PREFIX'_2.unpaired.fq' \
    ILLUMINACLIP:$ADAPTER_FILE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:90
