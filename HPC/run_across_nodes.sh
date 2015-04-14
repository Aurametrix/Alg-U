#!/bin/bash

while true;
do

shopt -s nullglob
#shopt -s dotglob # To include hidden files
files=(/home/cloudera/MyFolder/*)
echo "files in folder" $files[@]

if [  ${#files[@]} -gt 0 ];
then
        for entry in "/home/cloudera/EcoAxis"/*
    do
      cp $entry /home/cloudera/EcoBackup
      var=`basename $entry`
      var1=`echo ${var//[.csv]/}`
      echo $var1
      gawk -f abc.awk $entry
      rm -r -f $entry

    done
fi
 echo "server2" 
sleep 5s
 echo "sleep time................"
 sleep 10s
done
