#!/bin/bash

alias vcftools="/root/tools/apps/vcftools/vcftools_0.1.13/bin/vcftools"

VCF_IN=/root/results/ancestry/ref_chr2.vcf.gz
VCF_OUT=/root/results/ancestry/ref_chr2_filtered.vcf.gz

MAF=0.0007
MISS=0.9
QUAL=30
MIN_DEPTH=1
MAX_DEPTH=40

vcftools --gzvcf $VCF_IN \
--remove-indels --maf $MAF --max-missing $MISS --minQ $QUAL \
--min-meanDP $MIN_DEPTH --max-meanDP $MAX_DEPTH \
--minDP $MIN_DEPTH --maxDP $MAX_DEPTH --recode --stdout | gzip -c > \
$VCF_OUT

cat out.log
bcftools view -H $VCF_OUT | wc -l


