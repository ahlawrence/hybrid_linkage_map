family_name=""
inbred_Mom=""
inbred_Dad=""
F1M=""
F1D=""

rm test_ped.txt
printf "CHR\tCHR\tCHR\tCHR\tCHR\tCHR\n" >> test_ped.txt
printf "POS\tPOS\tPOS\tPOS\tPOS\tPOS\n" >> test_ped.txt
printf "$family_name\t$inbred_Dad\t0\t0\t1\t0\n" >> test_ped.txt
printf "$family_name\t$inbred_Mom\t0\t0\t2\t0\n" >> test_ped.txt
printf "$family_name\t$F1D\t$inbred_Dad\t$inbred_Mom\t1\t0\n" >> test_ped.txt
printf "$family_name\t$F1M\t$inbred_Dad\t$inbred_Mom\t2\t0\n" >> test_ped.txt
while IFS=$'\n', read -r f ; do
	printf "$family_name\t$f\t$F1D\t$F1M\t0\t0\n"  >> test_ped.txt
done <  individual_list.txt	
cat test_ped.txt | datamash transpose > ped.txt
