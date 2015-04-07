Common shells

sh – Bourne shell  (bash -c 'paste <(echo 1) <(echo 2)')

csh – C SHell   (csh -fc 'if (5 < 6) echo ok')

bash – Bourne Again Shell

tcsh – enhanced C Shell  (tcsh -c "source my.tcshr; useMyTcshCmd")

zsh – Z SHell  (zsh -c 'if [[ 5 -lt 6 ]] { echo ok };')

ksh – Korn SHell  (ksh -c 'let i=3+4; print $i')


Any shell:  sh -c "echo hello"


Most commonly used network commands:

– telnet – used for remote login

– ping – an echo request for testing connectivity

– su – user switching command

– ftp – file transfer protocol used for copying files

– finger – information gathering command


Piping, represented by the pipe character “|”, is used to combine two or more commands together.


Bash2048.sh
Bash implementation of popular 2048 game.
Controlled with arrow keys.

Bugs: https://github.com/mydzor/bash2048/issues
