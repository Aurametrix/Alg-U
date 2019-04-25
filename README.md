Common shells

sh – Bourne shell  (bash -c 'paste <(echo 1) <(echo 2)')

csh – C SHell   (csh -fc 'if (5 < 6) echo ok')

bash – Bourne Again Shell

tcsh – enhanced C Shell  (tcsh -c "source my.tcshr; useMyTcshCmd")

zsh – Z SHell  (zsh -c 'if [[ 5 -lt 6 ]] { echo ok };')

ksh – Korn SHell  (ksh -c 'let i=3+4; print $i')

es - mixed = {ls} hello, {wc} world

Any shell:  sh -c "echo hello"


Bash on Ubuntu on Windows10

Settings -> Update and Security -> Turn on Developer mode

From Start, search for "Turn Windows features on or off" (type 'turn')

Select Windows Subsystem for Linux (beta) & enable it via the GUI or the command-line: Turn on Developer Mode

Open a PowerShell prompt as administrator and run:

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux


Comparison table

| Feature                 | Bourne sh  | ash, dash | pdksh, mksh | bash      |
| :-----------------------|:----------:| :--------:| :----------:| :--------:|
| export PARAM=value      | NO         | YES       | YES         | YES       |
| local param             | NO         | YES       | YES         | YES       |




Most commonly used network commands:

– telnet – used for remote login

– ping – an echo request for testing connectivity

– su – user switching command

– ftp – file transfer protocol used for copying files

– finger – information gathering command

- Piping, represented by the pipe character “|”, is used to combine two or more commands together.

### What do command names stand for

+ awk = "Aho Weinberger and Kernighan"  - named by its authors, Al Aho, Peter Weinberger and Brian Kernighan. 
+ grep = g/re/p  - "Global Regular Expression Print" - print all lines matching a certain pattern 
+ [ripgrep](https://github.com/BurntSushi/ripgrep/releases/tag/0.10.0) - faster grep written in Rust
+ fgrep = "Fixed GREP". Searches for fixed strings only. 
+ egrep = "Extended GREP",  uses fancier regular expressions 
+ cat = "CATenate" 
+ gecos = "General Electric Comprehensive Operating Supervisor" 
+ nroff = "New ROFF" 
+ troff = "Typesetter new ROFF" 
+ bss = "Block Started by Symbol" 
+ curl https://example.com/setup.bash | (sleep 3; cat)   = Detecting a server detecting curl | bash

#### Handy Aliases
+ alias untar='tar -zxvf '
+ alias wget='wget -c '
+ ssl rand -base64 20"  // generate a random, 20-character password
+ alias sha='shasum -a 256 '   // checksum on a downloaded file
+ alias ping='ping -c 5' // limit to 5 pings
+ alias www='python -m SimpleHTTPServer 8000' // Start a web server in any folder you'd like
+ alias speed='speedtest-cli --server 2406 --simple' // find how fast your network is
+ alias ipe='curl ipinfo.io/ip'  // find external IP address
+ alias ipi='ipconfig getifaddr en0'  // find local IP adddress
+ alias c='clear'  // clear the screen


#### Linux v4.15: Performance Goodies

- epoll: scale nested calls
- pvspinlock: hybrid fairness paravirt semantics
- mm,x86: avoid saving/restoring interrupts state in gup
- ipc: scale INFO commands
- [ext4](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=232530680290ba94ca37852ab10d9556ea28badf): improve smp scalability for inode generation

+ [Browse or search Linux commands](linux-commands-examples.com)
+ [Linux Enhanced BPF (eBPF) Tracing Tools](http://www.brendangregg.com/ebpf.html)

+ [to validte user passwords](https://github.com/berzerk0/Probable-Wordlists)

+ [binary kernel interface](https://github.com/torvalds/linux/blob/master/Documentation/process/stable-api-nonsense.rst)
+ [using pseudo-therminals](http://rachid.koucha.free.fr/tech_corner/pty_pdip.html)

+ [Reliability of UNIX Utilities](http://ftp.cs.wisc.edu/paradyn/technical_papers/fuzz.pdf)

+ [UNIX as an IDE](https://sanctum.geek.nz/arabesque/series/unix-as-ide/?)

+ [NAvigate shell history](https://github.com/dvorka/hstr)

Bash2048.sh
Bash implementation of popular 2048 game.
Controlled with arrow keys.

Bugs: https://github.com/mydzor/bash2048/issues

Supported escape sequences:

| ~. | - terminate connection (and any multiplexed sessions) |   |   |   |
|----|-------------------------------------------------------|---|---|---|
| ~C | - open a command line                                 |   |   |   |
| ~R | - Request rekey (SSH protocol 2 only)</pre>           |   |   |   |
| ~# | - list forwarded connections</pre>                    |   |   |   |
| ~&   |  background ssh (when waiting for connections to terminate) |
| ~?   |  this message                                               |
| ~~   |  send the escape character by typing it twice               | 




+[Run Linux in your browser](https://bellard.org/jslinux/)

Upload files from command line:

    curl https://bashupload.com/name.txt --data-binary @file.txt


+ [Linux man pages](https://www.kernel.org/doc/man-pages/download.html)


#### Interesting projects

+ [SimulaVR](https://github.com/SimulaVR/Simula) - a 3D Linux window manager
+ [Gnome shell]()
