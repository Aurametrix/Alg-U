#!/bin/bash
#
# Used to submit jobs to the Queue Manager
#
# Version: 0.1 (24th October 2007)
# Author: Andrew
#

# Generate a job ID
jobid="`date +%y%m%d%H%M%S`-$RANDOM"

# Check to see if a parameter has been given
if [ $# != 1 ]
then
echo ' ERROR: Job to submit not specified'
echo ' '
echo " Usage: `basename $0` [file to submit]"
echo ' '
exit 1
fi

# Check to see if the file does not exist
if [ ! -e $1 ]
then
echo " ERROR: The file \"$1\" does not exist."
exit 1
fi

# Rename the current file
mv $1 ${jobid}.job

if [ $? -eq 0 ]
then
# Copy the job file
cp ${jobid}.job ${QUEUEPATH}
if [ $? -ne 0 ]
then
# Error copying to queue path
echo " ERROR: Unable to copy ${jobid}.job to ${QUEUEPATH}"
exit 1
fi
else
echo " ERROR: Unable to create new job file with ID: ${jobid}"
exit 1
fi

echo ' '
echo " You have been assigned job ID ${jobid}"
echo ' ************************************'
echo ' '
echo ' Please make a note of your job ID as you will need this'
echo ' to stop your job and/or know when your job has finished'
echo ' '
echo ' As a reminder, the job submission file has been renamed'
echo " to the corresponding job ID ${jobid}.job. This file"
echo ' can be safely deleted as the job is now in the queue.'
echo ' '
