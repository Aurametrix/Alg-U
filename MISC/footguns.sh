#!/bin/bash
SHOWTIMES=0
OPTIND=1
while getopts "h?v" opt; do
    case "$opt" in
        h|\?)
            echo "usage: $0 [-v]"
            exit 0
            ;;
        v)
            SHOWTIMES=1
            ;;
    esac
done

# N.B. must use "$@" here, NOT $*
run() {
    if [ "$SHOWTIMES" -eq 1 ]; then
        time "$@"
    else
        "$@"
    fi
}

run cp "./expense report.xls" "./funny    name.txt" /tmp
run dig www.google.com
# etc...
