echo aaaabcd | awk '{ sub(/a+/, "<A>"); print }'


BEGIN { digits_regexp = "[[:digit:]]+" }
$0 ~ digits_regexp    { print }
