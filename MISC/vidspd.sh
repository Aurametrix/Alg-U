ffmpeg -i "$1"  -filter_complex "[0:v]setpts=0.6666666666666*PTS[v];[0:a]atempo=1.5[a]" -map "[v]" -map "[a]" "tmp-$1"
    # Delay audio of $1 by 60ms to fix discrepancy caused by above step
    ffmpeg -i "tmp-$1" -itsoffset 0.06 -i "tmp-$1" -map "0:0" -map "1:1" -acodec copy -vcodec copy  "faster-$1"
    rm "tmp-$1"  # cleanup tmp file
