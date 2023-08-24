#!/bin/bash
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=8G
#$ -j y
#$ -l h_rt=48:0:0
#$ -m bea
#$ -t 1-15

##create directories where results of script will be stored, just for the first PBS ARRAY INDEX
if [ $SGE_TASK_ID == 1 ]
then
        cd /data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq/results/
        mkdir wgs_data
        cd wgs_data
        mkdir converted #converted files from SAM to BAM
        mkdir sorted #sorted and indexed files
        mkdir stats #summary stat
fi

cd

CODE_DIR=/data/SBBS-FumagalliLab/Horse/Ricardo/EquSeq #insert your code directory path here (pwd command)
RES=$CODE_DIR/results/wgs_data/sorted
RUNS_LIST=$CODE_DIR/data/cleaned_data/sra_runs_to_do.txt
DATA=$CODE_DIR/results/raw_files

echo '=================================='
echo -e "\nLoading modules\n"

module load samtools # general
module load bowtie2 #aligning
module load anaconda3 # python
conda activate horse_project #for fastq-tools


# file names based on job number
FILE=($(python3 $CODE_DIR/mapping/wgs_mapping.py $RUNS_LIST $DATA | tr -d "[''],"))

# pair ended reads
FILE_1=${FILE[0]} # 1st pair ended read
FILE_2=${FILE[1]} # 2nd pair ended read

# new shorter file name
FILE_PREFIX=${FILE[2]}

echo "read1: "$FILE_1
echo "read2: "$FILE_2
echo "prefix: "$FILE_PREFIX


echo '=================================='
echo -e "\nAligning\n"

FILE_1=$DATA/$FILE_1
FILE_2=$DATA/$FILE_2

FILE_RES=$RES/$FILE_PREFIX.sorted.bam

if [ -f "$FILE_RES" ]; then
    echo "$FILE_RES exists."
else
    sh $CODE_DIR/mapping/align_bowtie.sh $FILE_1 $FILE_2 $FILE_PREFIX $CODE_DIR/results/wgs_data/
fi











