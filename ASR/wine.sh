#  applications for text-for-speech wine and Windows TTSApp.exe

# Linux pico2wave program. In Ubuntu 14.04 it's part of libttspico-utils
# pico2wave --wave=test.wav "$(cat filename.txt)"

#converting windows files

#!/bin/bash
ARG=$1

for i in "${ARG}"/* ;
do
wine ttsUtil.exe "${i}" -voice=nick -output="${i}".wav
done

# to run: chmod +x wine.sh        ./wine.sh ~/path/to/files
