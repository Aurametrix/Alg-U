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

#to keep a process running after you log out:
disown -h <pid>

# rerun the previous command with sudo.
sudo !!

SECONDS=0; sleep 5 ; echo "that took approximately $SECONDS seconds"

# special variable $RANDOM produces a random number
echo $RANDOM

# To turn it into a random number between 0-5 use [ $RANDOM % 6 ]
if [[ $(($RANDOM % 6)) = 0 ]]
    then echo "BANG"
else
    echo "Try again"
fi

[ $RANDOM % 6 ] == 0 ] && rm -rf / || echo "Lucky boy";


# Concatenates the list files,
# sorts them,
# removes duplicate lines,
# and finally writes the result to an output file
cat list-1 list-2 list-3 | sort | uniq > final.list

