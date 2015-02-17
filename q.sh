# sync only files with the commonname in its path

rsync -a -m --include='**/commonname/*.foo' --include='*/' --exclude='*' root@1.2.3.4:/var/lib/data /var/lib/data

# sort the output from the command “who” (list of users), open logfile, arrange it together with the output 
# place the final sorted output to the file newfile.

$who | sort –logfile > newfile

# output the sorted contents of a file named IN.TXT into OUT.TXT, excluding duplicate entries.
sort IN.TXT | uniq > OUT.TXT

http://career.guru99.com/top-50-unix-interview-questions/

# rename all jpg files in a folder with hashing key "mykey123"
for file in `/bin/ls *.jpg`; do
    hashedFileName=`echo -n ${file%.*} | openssl dgst -sha1 -hmac "myKey123"`;
    mv $file $hashedFileName.jpg;
done
