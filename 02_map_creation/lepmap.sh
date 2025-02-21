java -cp ~/.conda/envs/java8/bin/binary+code/bin/ ParentCall2 data= /work/ahl28/QTL_Mapping/lepmap/IM_CS.ped.txt vcfFile = ${PRE}.thinned.vcf removeNonInformative=1 > lm.call


lod=''
theta=''

./remove_lines.sh bad_lines.txt lm.call

java -cp ~/.conda/envs/java8/bin/binary+code/bin/ SeparateChromosomes2 numThreads=8 grandparentPhase=1  data=lm.call lodLimit=$lod theta=$theta > map.$lod.$theta.pc.txt
java -cp   ~/.conda/envs/java8/bin/binary+code/bin/ OrderMarkers2 numThreads=8 grandparentPhase=1 data=lm.call map=map.$lod.$theta.pc.txt > order.$lod.$theta.pc.txt


#### Please Download map2genotypes.awk from the Lep-MAP3 Wiki ########
awk -vfullData=1 -f map2genotypes.awk order1.txt >qtldata1.12
cat data.call|cut -f 1,2|awk '(NR>=7)' >snps.txt
#note that first line of snps.txt contains "CHR POS"
awk -vFS="\t" -vOFS="\t" '(NR==FNR){s[NR-1]=$0}(NR!=FNR){if ($1 in s) $1=s[$1];print}' snps.txt qtldata1.12 > qtl_data.txt
#because of first line of snps.txt, we use NR-1 instead of NR
