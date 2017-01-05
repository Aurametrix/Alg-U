START=$(date +%s)
Add following at the end or exit location:
# some code goes here
END=$(date +%s)
DIFF=$(( $END - $START ))
DIFF=$(( $DIFF / 60 ))
