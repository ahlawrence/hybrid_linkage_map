


bcftools view -h ${PRE}$f.filtered.vcf > ${PRE}$c.norepeats.vcf 
bedtools intersect -v -a ${PRE}$f.filtered.vcf -b /work/eo22/01_mapping/repeats_tol.bed >>  ${PRE}$c.norepeats.vcf 
vcftools --vcf ${PRE}$c.norepeats.vcf --thin 150 --recode --recode-INFO-all --stdout > ${PRE}$c.thinned.vcf 

java -cp ~/.conda/envs/java8/bin/binary+code/bin/ ParentCall2 data= /work/ahl28/QTL_Mapping/lepmap/IM_CS.ped.txt vcfFile = ${PRE}$c.thinned.vcf removeNonInformative=1 > $c.call
