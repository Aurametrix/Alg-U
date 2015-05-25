echo "Memory Space Details"
set $( free -t -m | grep "Total")
printf "Total Memory space : %s MB\n" "$2"
printf "Used Memory Space : %s MB\n" "$3"
printf "Free Memory : %s MB\n" "$4"
