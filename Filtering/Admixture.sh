#!/bin/bash

#load tools
alias bcftools="/root/tools/apps/bcftools/bin/bcftools"
alias tabix="/root/tools/apps/htslib/bin/tabix"
alias bgzip="/root/tools/apps/htslib/bin/bgzip"
alias htsfile="/root/tools/apps/htslib/bin/htsfile"
alias samtools="/root/tools/apps/samtools/bin/samtools"
alias vcftools="/root/tools/apps/vcftools/vcftools_0.1.13/bin/vcftools"
alias gatk="/root/tools/apps/gatk/gatk-4.4.0.0/gatk"
alias plink="/root/tools/apps/plink/plink"
alias beagle="java -jar /root/tools/apps/beagle/beagle.r1399.jar"
alias shapeit="/root/tools/apps/shapeit/shapeit.v2.904.3.10.0-693.11.6.el7.x86_64/bin/shapeit"
alias admixture="/root/tools/apps/admixture/dist/admixture_linux-1.3.0/admixture"
alias admixture32="/root/tools/apps/admixture/dist/admixture_linux-1.3.0/admixture32"
alias evalAdmix="/root/tools/apps/evalAdmix/evalAdmix/evalAdmix"

FILE=/root/results/ancestry/ref_chr2_prun_15_PCA

# Run admixture analysis on QC-filtered data
for K in 1 - 70
do
 admixture --cv $FILE.bed $K > /root/results/ancestry/log_15th_$K.out
done
