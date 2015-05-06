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
