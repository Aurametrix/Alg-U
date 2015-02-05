declare BSORT=()
function bubble_sort()
{   #
    # @param [ARGUMENTS]...
    #
    # Sort all positional arguments and store them in global array BSORT.
    # Without arguments sort this array. Return the number of iterations made.
    #
    # Bubble sorting lets the heaviest element sink to the bottom.
    #
    (($# > 0)) && BSORT=("$@")
    local j=0 ubound=$((${#BSORT[*]} - 1))
    while ((ubound > 0))
    do
        local i=0
        while ((i < ubound))
        do
            if [ "${BSORT[$i]}" \> "${BSORT[$((i + 1))]}" ]
            then
                local t="${BSORT[$i]}"
                BSORT[$i]="${BSORT[$((i + 1))]}"
                BSORT[$((i + 1))]="$t"
            fi
            ((++i))
        done
        ((++j))
        ((--ubound))
    done
    echo $j
}

bubble_sort a c b 'z y' 3 5
echo ${BSORT[@]}
