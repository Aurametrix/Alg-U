#!/bin/bash

echo hello
echo $?    # Exit status 0 returned because command executed successfully.

lskdf      # Unrecognized command.
echo $?    # Non-zero exit status returned -- command failed to execute.

echo

exit 113   # Will return 113 to shell.
           # To verify this, type "echo $?" after script terminates.

#  By convention, an 'exit 0' indicates success,
#+ while a non-zero exit value means an error or anomalous condition.
#  Exit Codes With Special Meanings:
# 1 - general
# 2- misuse of shell buttons
# 126 - cannot execute
# 127 - command not found
# 128  invalid argument to exit
# 128+n fatal error
# 130 script terminated
# 255 exit status out of range
