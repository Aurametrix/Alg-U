# transfer.sh - Easy file sharing from the command line

# Upload using cURL 
$ curl --upload-file ./hello.txt https://transfer.sh/hello.txt https://transfer.sh/66nb8/hello.txt 

# Using the alias 
$ transfer hello.txt 
###################################s################## 100.0% https://transfer.sh/eibhM/hello.txt

# PUT misused?
cat ~/myfile | curl -X PUT --upload-file “-” https://transfer.sh/myfile.txt (transfer.sh)

# Uploading is easy using curl 
curl --upload-file ./hello.txt https://transfer.sh/hello.txt 
https://transfer.sh/66nb8/hello.txt 
# or with HTTPie[0]:
http PUT https://transfer.sh/hello.txt < ./hello.txt

# Download the file 
$ curl https://transfer.sh/66nb8/hello.txt -o hello.txt
