for f in *.txt; do
    echo $f; 
    tail –1 $f >> txt.tails; 
done
for (( j=0; j < 4; j++ )); do 
    cat part$j.txt >> parts0-3.txt; 
done
for f in hw1.*; do 
    mv $f ${f//hw1/hw2}; 
done


#####################3
head -n 2 file.csv
tail -n 1 file.csv
tail -n 42 file.csv
wc -l
wc - w

grep mutex file.csv | grep OS



cat
head
tail
wc
grep
cut
paste
sort
uniq
awk
tr
fold
sed
