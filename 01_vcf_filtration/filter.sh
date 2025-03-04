#add file name here
PRE=""



bcftools view -h ${PRE}.filtered.vcf > ${PRE}.norepeats.vcf 
bedtools intersect -v -a ${PRE}.filtered.vcf -b repeats_tol.bed >>  ${PRE}.norepeats.vcf 
vcftools --vcf ${PRE}.norepeats.vcf --thin 150 --recode --recode-INFO-all --stdout > ${PRE}.thinned.vcf 

java -cp ~/.conda/envs/java8/bin/binary+code/bin/ ParentCall2 data=ped.txt vcfFile = ${PRE}.thinned.vcf removeNonInformative=1 > ${PRE}.call
