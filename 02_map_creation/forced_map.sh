###### Forced MAP Version #####
vcftools --vcf  ${out_name}.filtered.vcf --thin 150 --recode --recode-INFO-all --stdout >  ${out_name}.thinned.vcf
#java -cp ~/.conda/envs/java8/bin/binary+code/bin/ ParentCall2 data=ped.txt vcfFile = ${out_name}.thinned.vcf removeNonInformative=1 > ${out_name}.call

./remove_lines.sh bad_lines.txt ${out_name}.call
cat ${out_name}.call|cut -f 1,2|awk '(NR>=7)' >snps.txt
echo "#line" > map.genome.txt
awk 'NR==1 {next} {for (i=1; i<=NF; i++) if (i!=2) printf "%s%s", $i, (i==NF || i==1 ? "\n" : " ")}' snps.txt > chrom.txt
sed -E 's/Chr_0|Chr_//g' chrom.txt >> map.genome.txt

java -cp   ~/.conda/envs/java8/bin/binary+code/bin/ OrderMarkers2 numThreads=8 grandparentPhase=1 data=${out_name}.call map=map.genome.txt > order.genome.pc.txt
awk -vfullData=1 -f map2genotypes.awk order.genome.pc.txt >qtldata1.12
awk -vFS="\t" -vOFS="\t" '(NR==FNR){s[NR-1]=$0}(NR!=FNR){if ($1 in s) $1=s[$1];print}' snps.txt qtldata1.12 > qtl_data.txt
