java -cp ~/.conda/envs/java8/bin/binary+code/bin/ ParentCall2 data= /work/ahl28/QTL_Mapping/lepmap/IM_CS.ped.txt vcfFile = ${PRE}.thinned.vcf removeNonInformative=1 > lm.call


lod='35'
theta='.37'

./remove_lines.sh bad_lines.txt lm.call

java -cp ~/.conda/envs/java8/bin/binary+code/bin/ SeparateChromosomes2 numThreads=8 grandparentPhase=1  data=lm.call lodLimit=$lod theta=$theta > map.$lod.$theta.pc.txt
java -cp   ~/.conda/envs/java8/bin/binary+code/bin/ OrderMarkers2 numThreads=8 grandparentPhase=1 data=lm.call map=map.$lod.$theta.pc.txt > order.$lod.$theta.pc.txt

