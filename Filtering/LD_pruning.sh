#!/bin/bash

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
alias admixture32="/root/tools/apps/admixture32/admixture32"
alias evalAdmix="/root/tools/apps/evalAdmix/evalAdmix/evalAdmix"

VCF=/root/results/ancestry/ref_chr2_filt_15.vcf
OUT=/root/results/ancestry/ref_chr2_filt_prun_15

plink --vcf $VCF  \
--maf 0.004 \
--indep-pairwise 50 10 0.1 \
--horse \
--out $OUT

#plink --vcf $VCF  \
#--extract ref_chr2_noLD.prune.in \
#--make-bed \
#--horse \
#--out $OUT
