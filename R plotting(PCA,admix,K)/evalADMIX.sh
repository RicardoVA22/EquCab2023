#! /bin/bash

alias bcftools="/root/tools/apps/bcftools/bin/bcftools"
alias tabix="/root/tools/apps/htslib/bin/tabix"
alias bgzip="/root/tools/apps/htslib/bin/bgzip"
alias htsfile="/root/tools/apps/htslib/bin/htsfile"
alias samtools="/root/tools/apps/samtools/bin/samtools"
alias vcftools="/root/tools/apps/vcftools/vcftools_0.1.13/bin/vcftools"
alias gatk="/root/tools/apps/gatk/gatk-4.4.0.0/gatk"
alias plink="/root/tools/apps/plink/plink"
alias beagle="java -jar /root/tools/apps/beagle/beagle.r1399.jar"
alias shapeit="/root/tools/apps/shapeit/shapeit.v2.904.3.10.0-693.11.6.el7.x86_64/bin/shape"alias admixture="/roo>alias admixture32="/root/tools/apps/admixture32/admixture32"
alias evalAdmix="/root/tools/apps/evalAdmix/evalAdmix/evalAdmix"

CODE_DIR=/root/results/ancestry/new_data_15

for NUM in 1 -70 >do
    evalAdmix -plink $CODE_DIR/ref_chr2_prun_15_PCA \
    -fname $CODE_DIR/ref_chr2_prun_15_PCA.$NUM.P \
    -qname $CODE_DIR/ref_chr2_prun_15_PCA.$NUM.Q \
    -o $CODE_DIR/evalAdmix.$NUM.corr  -P 16
done

#evalAdmix -plink $CODE_DIR/ref_chr2_prun_15_PCA \
#-fname $CODE_DIR/ref_chr2_prun_15_PCA.54.P \
#-qname $CODE_DIR/ref_chr2_prun_15_PCA.54.Q \
#-o $CODE_DIR/evalAdmix.54.corr  -P 16
