#!/bin/bash
# Usage: merge.sh val1 val2 [val3] ... [valn]
merge(){
	# $1: low, $2: mid, $3: high
	local h=$1
	local i=$1
	local j=$(( $2 + 1 ))
	
	while [ $h -le $2 ] && [ $j -le $3 ]; do
		eval val1='$arr'$h
		eval val2='$arr'$j 
		if [ $val1 -le $val2 ]; then
			eval brr$i=$val1
			h=$(($h+1))
		else
			eval brr$i=$val2
			j=$(($j+1))
		fi
		i=$(( $i+1 ))
	done
	
	if [ $h -gt $2 ]; then
		for((k=$j;k<=$3;k++)){
			#in
			eval brr$i='$arr'$k
			i=$(( $i+1 ))
		}
	else
		for((k=$h;k<=$2;k++)){
			# in
			eval brr$i='$arr'$k
			i=$(( $i+1 ))
		}
	fi
	
	for(( k=$1;k<=$3;k++ )){
		# in
		eval arr$k='$brr'$k
	}
}

mergeSort(){
	# $1: low, $2: high
	#echo "MergeSort $1 to $2"
	if [ $1 -lt $2 ]; then
		local mid=$(( ($1+$2)/2 ))
		mergeSort $1 $mid
		mergeSort $(($mid + 1)) $2
		merge $1 $mid $2
	fi
}


echo "Before Sort: "
for((i=1;i<=$#;i++)){
	# in
	eval arr$i='$'$i
	eval echo -n '$arr'$i
	echo -n " "
}
echo " "

mergeSort 1 $#


echo "After Sort: "
for((i=1;i<=$#;i++)){
	# in
	eval echo -n '$arr'$i
	echo -n " "
}
echo " "

exit 0
