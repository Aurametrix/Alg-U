#!/bin/bash

# get unique match rates for each pair of scaffolds
# | of each unique match rate, take the scaffold names
# | count the number of times each pair of names appears
# | take only the pairs that appeared once (had only one match rate)
read -d '' get_uniform_matches <<"EOF"
  sort -u \
    | cut -d, -f1,2 \
    | sort | uniq -c \
    | grep '1 '
EOF

# get scaffold pairs where the first is a subset of the second
# | take scaffold names
# | uniquify
read -d '' get_perfect_matches <<"EOF"
  grep '100.00' \
    | cut -d, -f1,2 \
    | sort -u
EOF

# get all seqs that had 100 pct matches
head alignments_${1}_${2}_${3}_${4}.log \
  | cut -d, -f1,2,3 \
  | tee >(eval $get_uniform_matches > uniform_matches.log ) \
  | eval $get_perfect_matches \
  > perfect_matches.log
