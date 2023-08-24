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

# Path to the FASTQC executable
module load fastQC

# Create the output directory if it doesn't exist
mkdir -p "$RES_DIR"

# List of filenames (can be customized based on your filenames)
files=*.fastq

# Loop through each filename and run FASTQC
for file in "${files[@]}"; do
    # Construct the full path to the input file
    input_file="$CODE_DIR/raw_reads/$file"

    # Run FASTQC on the file and save the output in the output directory
    fastqc "$CODE_DIR" --outdir "$RES_DIR"

    echo "FASTQC completed for $file"
done

echo "FASTQC analysis completed for all files."
