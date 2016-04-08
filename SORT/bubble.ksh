#!/bin/ksh93
 
typeset -A count
 
# create an associative array
while read ip
do
    (( count[$ip]++ ))
done < infile
 
# sort print the associative array
while (( 1 ))
do
   [[ ${#count[@]} == 0 ]] && break;
   k=(${!count[@]})
   for j in ${!count[@]}
   do
      (( ${count[$j]} > ${count[$k]} )) && k=$j
   done
   echo "$k : ${count[$k]}"
   unset count[$k]
done
