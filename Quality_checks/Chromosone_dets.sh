alias vcftools="/root/tools/apps/vcftools/vcftools_0.1.13/bin/vcftools"

VCF=/root/results/Initial_VCF/ref_chr2.vcf
OUT=/root/results/Summary_files/ref2_chr


vcftools --vcf $VCF --freq2 --out $OUT --max-alleles 2
vcftools --vcf $VCF --depth --out $OUT
vcftools --vcf $VCF --site-mean-depth --out $OUT
vcftools --vcf $VCF --site-quality --out $OUT
vcftools --vcf $VCF --missing-indv --out $OUT
vcftools --vcf $VCF --missing-site --out $OUT
vcftools --vcf $VCF --het --out $OUT




