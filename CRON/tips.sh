# Execute a cron job every 5 minutes
*/5 * * * * /user/backup.sh
# Execute a cron job every 5 hours
B */5 * * *  /user/backup.sh

# create a shell script every 5 seconds using bash while loop
#!/bin/bash
while true
do
 /user/backup.sh
 sleep 5
done
