#!/bin/bash

##
#
# ARRAY FUNCTIONS
# Various functions for bash arrays -- mostly reimplementations from
# "Mastering Algorithms in Perl"
# Reimplemented by: Michael A. Smith, aka kojiro, <michael at smith dash li
#                                                  dot com>
#
# Last Modified: 2009-10-10
# Usage and comments: You can just source the file to get access to the
# functions in your script. If you want to test some functions,
# ./sort.bash -t funclist
#
# This code is released AS-IS, under an MIT license. The MIT license can be
# found at http://www.opensource.org/licenses/mit-license.php and is included
# for your convenience at the bottom of this file.
##

##
#
# Utility algorithms
#
##

##
# numeric_cmp()
# Input: lhs(integer) rhs(integer)
# Returns: 0 if lhs == rhs; 2 if lhs < rhs; 3 if lhs > rhs; 1 if error
# Use:     Default comparison function. See the "Use" for compare().
numeric_cmp() {
	(( $1 == $2 )) && return 0
	(( $1 <  $2 )) && return 2
	(( $1  > $2 )) && return 3
}

##
# lexical_cmp()
# Input:   lhs(string) rhs(string)
# Returns: 0 if lhs == rhs; 2 if lhs < rhs; 3 if lhs > rhs; 1 if error
# Use:     Example lexical (alphabetical) comparison function.
#          See the "Use" for compare().
lexical_cmp() {
	[[ $1 == $2 ]] && return 0
	[[ $1 <  $2 ]] && return 2
	[[ $1  > $2 ]] && return 3
}

##
# filesize_cmp()
# Input:   lhs(filename) rhs(filename)
# Returns: 0 if lhs == rhs; 2 if lhs < rhs; 3 if lhs > rhs; 1 if error
# Use:     Example filesize comparison function. Neither a fast nor a
#          particularly precise implementation, but should work and serve as
#          another example how to make a compare() function.
#          See the "Use" for compare().
filesize_cmp() {
	local lhs=$(du "$1")
	local rhs=$(du "$2")
	numeric_cmp "$lhs" "$rhs"
}

##
# compare():
# Input:   lhs rhs
# Returns: 0 if lhs == rhs; 2 if lhs < rhs; 3 if lhs > rhs; 1 if error
# Use:     Define this function in order to tell the below functions how to
#          compare values. If you don't define it, numeric_cmp will be
#          assumed.
if ! declare -f compare > /dev/null; then
	compare() {
		numeric_cmp "$@"
	}
fi

##
# splice():
# Input: offset length array-to-splice
# var:   set the variable SPLICEINPUT prior to calling
# Use:   Removes the elements designated by offset and length from an array,
#        and replaces them with the elements of SPLICEINPUT, if any.
splice() {
	local offset=$1
	local length=$2
	shift 2
	SPLICEARRAY=("$@")
	local -a backarray
	local i
	for (( i=${#SPLICEARRAY[@]}; i>=offset; i-- )); do
		(( i>=offset+length )) && backarray[i]="${SPLICEARRAY[i]}"
		unset SPLICEARRAY[i]
	done
	SPLICEARRAY+=("${SPLICEINPUT[@]}" "${backarray[@]}")
}

##
#
# Min/Max: Straightforward one-pass extrema searches
# Input:   Word list
# Output:  Scalar global variable
#
##

##
# min():
# Set the value of ARRAYMIN to the smallest word in the input list.
min() {
	ARRAYMIN="$1"
	while [[ $2 ]]; do
		compare "$ARRAYMIN" "$2"
		(( $? == 3 )) && ARRAYMIN="$2"
		shift
	done
}

##
# max():
# Set the value of ARRAYMAX to the largest word in the input list.
max() {
	ARRAYMAX="$1"
	while [[ $2 ]]; do
		compare "$ARRAYMAX" "$2"
		(( $? == 2 )) && ARRAYMAX="$2"
		shift
	done
}

##
#
# Sort Algorithms
# Input:  Word list
# Output: Global array variable SORTEDARRAY
#
##

##
# selsort():   (Selection Sort)
# Worst-case:  Î©(N^2) (slow)
# Stability:   stable
# Sensitivity: insensitive
# Use:         Quickly find extrema for unordered data
selsort() {
	local i m x j t
	SORTEDARRAY=("$@")
	for (( i=0; i < ${#SORTEDARRAY[@]}; i++ )); do
		(( m=i ))
		x="${SORTEDARRAY[m]}" # The minimum value
		for (( j=i+1; j < ${#SORTEDARRAY[@]}; j++ )); do
			compare "${SORTEDARRAY[j]}" x
			(( $? == 2 )) || continue
			(( m=j ))
			x="${SORTEDARRAY[j]}"
		done

		# Swap if needed
		(( m == i )) && continue
		t="${SORTEDARRAY[m]}" # Placeholder for swapping elements
		SORTEDARRAY[m]="${SORTEDARRAY[i]}"
		SORTEDARRAY[i]="$t"
	done
}

##
# bsort():     (Bubble Sort)
# Worst-case:  Î©(N^2) (slow)
# Stability:   stable
# Sensitivity: insensitive
# Use: Fastest type of sort for nearly-sorted data.
bsort() {
	SORTEDARRAY=("$@")
	local i j t
	for (( i=${#SORTEDARRAY[@]}-1; i>0; i-- )); do
		for (( j=1; j<=i; j++ )); do
			# Swap if needed
			compare "${SORTEDARRAY[j-1]}" "${SORTEDARRAY[j]}" 
			(( $? == 3 )) || continue
			t="${SORTEDARRAY[j]}" # Placeholder for swapping elements
			SORTEDARRAY[j]="${SORTEDARRAY[j-1]}"
			SORTEDARRAY[j-1]="$t"
		done
	done
}

##
# bsmart(): (Sensitive, fast Bubble Sort variant)
# Use:      quickly reduces the bounds of the bubblesort input list to sort as
#           little as possible -- even better than bsort for nearly-sorted data.
bsmart() {
	SORTEDARRAY=("$@")
	local start= i new_start new_end j t
	(( i=${#SORTEDARRAY[@]}-1 ))
	while [[ 1 ]]; do
		new_start= # New start index of the bubbling scan
		new_end=   # New end index of the bubbling scan
		for (( j=start>0?start:1; j<=i; j++ )); do
			# Swap if needed
			compare "${SORTEDARRAY[j-1]}" "${SORTEDARRAY[j]}"
			(( $? == 3 )) || continue
			t="${SORTEDARRAY[j]}" # Placeholder for swapping elements
			SORTEDARRAY[j]="${SORTEDARRAY[j-1]}"
			SORTEDARRAY[j-1]="$t"
			(( new_end=j-1 ))
			new_start="${new_start:-$new_end}"
		done
		[[ $new_start ]] || break # No swaps: we're done.
		i=$new_end
		start=$new_start
	done
}

##
# insort():    (Insertion Sort)
# Worst-case:  Î©(N^2) (slow)
# Stability:   stable
# Sensitivity: insensitive
# Use: Fastest type of sort for nearly-sorted data.
insort() {
	SORTEDARRAY=("$@")
	local i m x j
	for (( i=0; i<${#SORTEDARRAY[@]}; i++ )); do
		m="$i"                # Final index for the minimum element
		x="${SORTEDARRAY[m]}" # Minimum value
		for (( j=i+1; j<${#SORTEDARRAY[@]}; j++ )); do
			compare "${SORTEDARRAY[j]}" x
			(( $? == 2 )) || continue
			m="$j"
			x="${SORTEDARRAY[j]}"
		done
		# Insert the m'th element at i, and move i and everything following it up
		# one.
		for (( j=m; j>i; j-- )); do
			SORTEDARRAY[j]="${SORTEDARRAY[j-1]}"
		done
		SORTEDARRAY[i]="$x"
	done
}

##
# shellsort(): (Shell Sort)
# Worst-case:  Î©(N((log N)/(log log N))^2)
#              (can be fast, but sensitive to input data)
# Stability:   stable
# Sensitivity: sensitive
shellsort() {
	SORTEDARRAY=("$@")
	local shell i j t
	for (( shell=1; shell<${#SORTEDARRAY[@]}; 1 )); do
		(( shell=2*shell+1 )) # Just let the shell grow.
	done

	while [[ 1 ]]; do
		(( shell=(shell-1)/2 ))
		for (( i=shell; i<${#SORTEDARRAY[@]}; i++)); do
			for (( j=i-shell; j>=0; j-=shell )); do
				compare "${SORTEDARRAY[j]}" "${SORTEDARRAY[j+shell]}"
				(( $? == 3 )) || break
				t="${SORTEDARRAY[j]}"
				SORTEDARRAY[j]="${SORTEDARRAY[j+shell]}"
				SORTEDARRAY[j+shell]="$t"
			done
		done
		(( shell > 1 )) || break
	done
}

##
# msort():     (Merge sort)
# Average:     Î¸(N(log N)) (pretty fast)
# Stability:   stable
# Sensitivity: insensitive to the key distribution of the input
# Drawbacks:   Requires temporary space equal in size to the input array.
# msort will use recursion by default -- msort_iter is additionally provided.
msort() {
	SORTEDARRAY=("$@")
	msort_recurse 0 $((${#@}-1))
	unset msortWrkArr
}
msort_recurse()	{
	local first=$1
	local last=$2
	shift 2
	(( last > first )) || return 0
	local middle
	(( middle=(last+first)/2 ))
	msort_recurse $first $middle "${SORTEDARRAY[@]}"
	msort_recurse $(( middle+1 )) $last "${SORTEDARRAY[@]}"
	merge $first $middle $last "${SORTEDARRAY[@]}"
}
declare -a msortWrkArr # Global work array
unset msortWrkArr
merge() {
	local first=$1
	local middle=$2
	local last=$3
	shift 3
	local n i j n1
	(( n=last-first+1 ))

	# Initialize msortWrkArr with relevant elements from the array
	for (( i=first, j=0; i<=last; )); do
		msortWrkArr[j++]="${SORTEDARRAY[i++]}"
	done

	# Actual merge. Proceed through msortWrkArr[] and copy elements in order back to
	# SORTEDARRAY[]. $i is index for the merge result, $j is index in first half
	# of the working copy, $k is index in second half.
	(( middle>last )) && (( middle=(first+last)/2 ))
	(( n1=middle-first+1 )) # Size of first half
	for (( i=first, j=0, k=n1; i<=last; i++ )); do
		if {
			(( j < n1 )) && {
				(( k == n )) || {
					compare "${msortWrkArr[j]}" "${msortWrkArr[k]}";
					(( $? == 2 ))
				}
			}
		}; then
			SORTEDARRAY[i]="${msortWrkArr[j++]}"
		else
			SORTEDARRAY[i]="${msortWrkArr[k++]}"
		fi
	done
}
msort_iter() {
	SORTEDARRAY=("$@")
	local N Nt2 Nm1 first middle last
	(( N=${#SORTEDARRAY[@]},
	   Nt2=N*2,
	   Nm1=N-1
	))
	for (( size=2; size<Nt2; size*=2 )); do
		for (( first=0; first<N; first+=size )); do
			(( last=first+size-1 ))
			(( middle=(first+last)/2 ))
			if (( last<N )); then
				merge $first $middle $last
			else
				merge $first $middle $Nm1
			fi
		done
	done
}
##
# hsort():     (Heap sort)
# Average:     Î¸(N(log N)) (pretty fast)
# Stability:   unstable
# Uses:        Best sort for certain graph algorithms
hsort() {
	local index last t
	SORTEDARRAY=("$@")
	for (( index=1+${#SORTEDARRAY[@]}/2; index--; )); do heapify $index; done
	for (( last=${#SORTEDARRAY[@]}; --last; )); do
		t="${SORTEDARRAY[0]}"
		SORTEDARRAY[0]="${SORTEDARRAY[last]}"
		SORTEDARRAY[last]="$t"
		heapify 0 $last
	done
}
heapify() {
	local index last swap high try t
	index=$1 last=${2:-${#SORTEDARRAY[@]}}
	swap=$index
	(( high=index*2+1 ))
	for (( try=index*2; try<last && try<=high; try++ )); do
		compare "${SORTEDARRAY[try]}" "${SORTEDARRAY[swap]}"
		(( $?==3 )) && swap=$try
		# (( SORTEDARRAY[try]>SORTEDARRAY[swap] )) && swap=$try
	done
	if (( swap != index )); then
		# The heap is in disorder. Must reshuffle
		t="${SORTEDARRAY[swap]}"
		SORTEDARRAY[swap]="${SORTEDARRAY[index]}"
		SORTEDARRAY[index]="$t"
		heapify $swap $last
	fi
}

##
# qsort():  (Quick sort)
# Average:
# Stability:
# Uses:
qsort() {
	SORTEDARRAY=("$@")
	qsort_recurse 0 $((${#@}-1))	
}
qsort_recurse() {
	local -i l r m i j k # left, right, mid bounds and some iterators
	local part temp      # partition value and temporary storage
	(( l=i=$1, r=j=$2, m=(l+r)/2 ))
	part="${SORTEDARRAY[m]}"
	while ((j > i)); do
		while [[ 1 ]]; do
			compare "${SORTEDARRAY[i]}" "$part"
			(( $? == 2 && i++ )) || break
		done
		while [[ 1 ]]; do
			compare "${SORTEDARRAY[j]}" "$part"
			(( $? == 3 && j-- )) || break
		done
		if (( i <= j )); then
			temp="${SORTEDARRAY[i]}"
			SORTEDARRAY[i]="${SORTEDARRAY[j]}"
			SORTEDARRAY[j]="$temp"
			(( i++, j-- ))
		fi
	done
	(( l<j )) && qsort_recurse $l $j
	(( r>i )) && qsort_recurse $i $r
}

##
#
# Tests: For making sure the above algorithms suck as little as possible.
#
##

if [[ $1 = -d ]]; then
	shift
	set -xv
fi
if [[ $1 = -t && $2 ]]; then
	shift
	testrunner() (
		while read _ _ f; do
			[[ $f = test_* ]] && unset -f "$f"
		done < <(declare -F)
		get_random_array() {
			local i j=${1:-10}
			RANDOM=$(date +%s)
			for ((i=0; i<j; i++)); do RANDOM_ARRAY[i]=$RANDOM; done
		}
		test_splice() {
			local -a SPLICEINPUT=(forty seven twins were born in Santa Barbara)
			local -a SPLICEARRAY
			splice 4 3 "${RANDOM_ARRAY[@]}"
			echo "Spliced from 4 to +3: ${SPLICEARRAY[@]}"
		}
		test_selsort() {
			local -a SORTEDARRAY
			selsort "${RANDOM_ARRAY[@]}"
			echo "Selection Sorted: ${SORTEDARRAY[@]}"
		}
		test_min() {
			local ARRAYMIN
			min "${RANDOM_ARRAY[@]}"
			echo "Min: $ARRAYMIN"
		}
		test_max() {
			local ARRAYMAX
			max "${RANDOM_ARRAY[@]}"
			echo "Max: $ARRAYMAX"
		}
		test_bsort() {
			local -a SORTEDARRAY
			bsort "${RANDOM_ARRAY[@]}"
			echo "Bubble Sorted: ${SORTEDARRAY[@]}"
		}
		test_bsmart() {
			local -a SORTEDARRAY
			bsmart "${RANDOM_ARRAY[@]}"
			echo "Bubble Smart Sorted: ${SORTEDARRAY[@]}"
		}
		test_insort() {
			local -a SORTEDARRAY
			insort "${RANDOM_ARRAY[@]}"
			echo "Insertion Sorted: ${SORTEDARRAY[@]}"
		}
		test_shellsort() {
			local -a SORTEDARRAY
			shellsort "${RANDOM_ARRAY[@]}"
			echo "Shell Sorted: ${SORTEDARRAY[@]}"
		}
		test_msort() {
			local -a SORTEDARRAY
			msort "${RANDOM_ARRAY[@]}"
			echo "Merge Sorted: ${SORTEDARRAY[@]}"
		}
		test_msort_iter() {
			local -a SORTEDARRAY
			msort "${RANDOM_ARRAY[@]}"
			echo "Merge Sorted: ${SORTEDARRAY[@]}"
		}
		test_hsort() {
			local -a SORTEDARRAY
			hsort "${RANDOM_ARRAY[@]}"
			echo "Heap Sorted: ${SORTEDARRAY[@]}"
		}
		test_qsort() {
			local -a SORTEDARRAY
			qsort "${RANDOM_ARRAY[@]}"
			echo "Quick Sorted: ${SORTEDARRAY[@]}"
		}
		# Get list of test function names
		while [[ $1 ]]; do
			local tested=
			while read _ _ func; do
				[[ $func = test_* ]] || continue
				if [[ test_$1 = $func ]]; then
					get_random_array
					echo "An array of random numbers: ${RANDOM_ARRAY[@]}"
					"$func"
					tested=1
					break
				fi
			done < <(declare -F)
			[[ $tested ]] || echo "test_$1 is not defined."
			shift
		done
	)
	testrunner "$@"
fi

# The MIT License

# Copyright (c) 2009 Michael A. Smith

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
