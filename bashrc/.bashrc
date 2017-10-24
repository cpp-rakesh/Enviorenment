# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#####################################################################################
#                                                                                   #
#                          Rocky Marrone's settings                                 #
#                                                                                   #
#####################################################################################

#!/bin/bash
iatest=$(expr index "$-" i)

#######################################################
# SOURCED ALIAS'S AND SCRIPTS
#######################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#######################################################
# EXPORTS
#######################################################

# Disable the bell
if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
export EDITOR=nano
export VISUAL=nano
alias pico='edit'
alias spico='sedit'
alias nano='edit'
alias snano='sedit'

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
export GREP_OPTIONS='--color=auto'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# MACHINE SPECIFIC ALIAS'S
#######################################################

# Alias's for SSH
# alias SERVERNAME='ssh YOURWEBSITE.com -l USERNAME -p PORTNUMBERHERE'

# Alias's to change the directory
alias web='cd /var/www/html'

# Alias's to mount ISO files
# mount -o loop /home/NAMEOFISO.iso /home/ISOMOUNTDIR/
# umount /home/NAMEOFISO.iso
# (Both commands done as root only.)

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we preceed the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Edit this .bashrc file
alias ebrc='edit ~/.bashrc'

# Show help for this .bashrc file
alias hlp='less ~/.bashrc_help'

# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias emacs='emacs -nw'

# Alias's for configuration editing
alias b='emacs ~/.bashrc'
alias e='emacs ~/.emacs'

# saving configuration
alias s='. ~/.bashrc'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Show current network connections to the server
alias ipview="netstat -anpl | grep :80 | awk {'print \$5'} | cut -d\":\" -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"

# Show open ports
alias openports='netstat -nape --inet'

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# SHA1
alias sha1='openssl sha1'

## Aliases for git hub
alias gh='cd ~/git_hub'
alias gd='git show --color --pretty=format:%b $COMMIT'

## Alias for g++
alias g++='g++ -std=c++11'

## Alias for comptitive programming
alias lt='javaws /home/rocky/rocky/code_env/ContestAppletProd.jnlp'

#######################################################
# SPECIAL FUNCTIONS
#######################################################

# Use the best version of pico installed
edit() {
    if [ "$(type -t jpico)" = "file" ]; then
	# Use JOE text editor http://joe-editor.sourceforge.net/
	jpico -nonotice -linums -nobackups "$@"
    elif [ "$(type -t nano)" = "file" ]; then
	nano -c "$@"
    elif [ "$(type -t pico)" = "file" ]; then
	pico "$@"
    else
	vim "$@"
    fi
}

sedit() {
    if [ "$(type -t jpico)" = "file" ]; then
	# Use JOE text editor http://joe-editor.sourceforge.net/
	sudo jpico -nonotice -linums -nobackups "$@"
    elif [ "$(type -t nano)" = "file" ]; then
	sudo nano -c "$@"
    elif [ "$(type -t pico)" = "file" ]; then
	sudo pico "$@"
    else
	sudo vim "$@"
    fi
}

# Extracts any archive(s) (if unp isn't installed)
extract() {
    for archive in $*; do
	if [ -f $archive ] ; then
	    case $archive in
		*.tar.bz2)   tar xvjf $archive    ;;
		*.tar.gz)    tar xvzf $archive    ;;
		*.tar.xz)    tar xf   $archive    ;;                
		*.bz2)       bunzip2 $archive     ;;
		*.rar)       rar x $archive       ;;
		*.gz)        gunzip $archive      ;;
		*.tar)       tar xvf $archive     ;;
		*.tbz2)      tar xvjf $archive    ;;
		*.tgz)       tar xvzf $archive    ;;
		*.zip)       unzip $archive       ;;
		*.Z)         uncompress $archive  ;;
		*.7z)        7z x $archive        ;;
		*)           echo "don't know how to extract '$archive'..." ;;
	    esac
	else
	    echo "'$archive' is not a valid file!"
	fi
    done
}

# Searches for text in all files in the current folder
ftext() {
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Copy and go to the directory
cpg () {
    if [ -d "$2" ];then
	cp $1 $2 && cd $2
    else
	cp $1 $2
    fi
}

# Move and go to the directory
mvg () {
    if [ -d "$2" ];then
	mv $1 $2 && cd $2
    else
	mv $1 $2
    fi
}

# Create and go to the directory
mkdirg () {
    mkdir -p $1
    cd $1
}

# Goes up a specified number of directories  (i.e. up 4)
up () {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
	d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
	d=..
    fi
    cd $d
}

#Automatically do an ls after each cd
# cd ()
# {
# 	if [ -n "$1" ]; then
# 		builtin cd "$@" && ls
# 	else
# 		builtin cd ~ && ls
# 	fi
# }

# Returns the last 2 fields of the working directory
pwdtail() {
    pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Show the current distribution
distribution() {
    local dtype
    # Assume unknown
    dtype="unknown"
    
    # First test against Fedora / RHEL / CentOS / generic Redhat derivative
    if [ -r /etc/rc.d/init.d/functions ]; then
	source /etc/rc.d/init.d/functions
	[ zz`type -t passed 2>/dev/null` == "zzfunction" ] && dtype="redhat"
	
	# Then test against SUSE (must be after Redhat,
	# I've seen rc.status on Ubuntu I think? TODO: Recheck that)
    elif [ -r /etc/rc.status ]; then
	source /etc/rc.status
	[ zz`type -t rc_reset 2>/dev/null` == "zzfunction" ] && dtype="suse"
	
	# Then test against Debian, Ubuntu and friends
    elif [ -r /lib/lsb/init-functions ]; then
	source /lib/lsb/init-functions
	[ zz`type -t log_begin_msg 2>/dev/null` == "zzfunction" ] && dtype="debian"
	
	# Then test against Gentoo
    elif [ -r /etc/init.d/functions.sh ]; then
	source /etc/init.d/functions.sh
	[ zz`type -t ebegin 2>/dev/null` == "zzfunction" ] && dtype="gentoo"
	
	# For Mandriva we currently just test if /etc/mandriva-release exists
	# and isn't empty (TODO: Find a better way :)
    elif [ -s /etc/mandriva-release ]; then
	dtype="mandriva"

	# For Slackware we currently just test if /etc/slackware-version exists
    elif [ -s /etc/slackware-version ]; then
	dtype="slackware"

    fi
    echo $dtype
}

# Show the current version of the operating system
ver() {
    local dtype
    dtype=$(distribution)

    if [ $dtype == "redhat" ]; then
	if [ -s /etc/redhat-release ]; then
	    cat /etc/redhat-release && uname -a
	else
	    cat /etc/issue && uname -a
	fi
    elif [ $dtype == "suse" ]; then
	cat /etc/SuSE-release
    elif [ $dtype == "debian" ]; then
	lsb_release -a
	# sudo cat /etc/issue && sudo cat /etc/issue.net && sudo cat /etc/lsb_release && sudo cat /etc/os-release # Linux Mint option 2
    elif [ $dtype == "gentoo" ]; then
	cat /etc/gentoo-release
    elif [ $dtype == "mandriva" ]; then
	cat /etc/mandriva-release
    elif [ $dtype == "slackware" ]; then
	cat /etc/slackware-version
    else
	if [ -s /etc/issue ]; then
	    cat /etc/issue
	else
	    echo "Error: Unknown distribution"
	    exit 1
	fi
    fi
}

# Automatically install the needed support files for this .bashrc file
install_bashrc_support() {
    local dtype
    dtype=$(distribution)

    if [ $dtype == "redhat" ]; then
	sudo yum install multitail tree joe
    elif [ $dtype == "suse" ]; then
	sudo zypper install multitail
	sudo zypper install tree
	sudo zypper install joe
    elif [ $dtype == "debian" ]; then
	sudo apt-get install multitail tree joe
    elif [ $dtype == "gentoo" ]; then
	sudo emerge multitail
	sudo emerge tree
	sudo emerge joe
    elif [ $dtype == "mandriva" ]; then
	sudo urpmi multitail
	sudo urpmi tree
	sudo urpmi joe
    elif [ $dtype == "slackware" ]; then
	echo "No install support for Slackware"
    else
	echo "Unknown distribution"
    fi
}

# Show current network information
netinfo() {
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    echo ""
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    echo ""
    /sbin/ifconfig | awk /'inet addr/ {print $4}'

    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    echo "---------------------------------------------------"
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip() {
    # Dumps a list of all IP addresses for every device
    # /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

    # Internal IP Lookup
    echo -n "Internal IP: " ; /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'

    # External IP Lookup
    echo -n "External IP: " ; wget http://smart-ip.net/myip -O - -q
}

# View Apache logs
apachelog() {
    if [ -f /etc/httpd/conf/httpd.conf ]; then
	cd /var/log/httpd && ls -xAh && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
    else
	cd /var/log/apache2 && ls -xAh && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
    fi
}

# Edit the Apache configuration
apacheconfig() {
    if [ -f /etc/httpd/conf/httpd.conf ]; then
	sedit /etc/httpd/conf/httpd.conf
    elif [ -f /etc/apache2/apache2.conf ]; then
	sedit /etc/apache2/apache2.conf
    else
	echo "Error: Apache config file could not be found."
	echo "Searching for possible locations:"
	sudo updatedb && locate httpd.conf && locate apache2.conf
    fi
}

# Edit the PHP configuration file
phpconfig() {
    if [ -f /etc/php.ini ]; then
	sedit /etc/php.ini
    elif [ -f /etc/php/php.ini ]; then
	sedit /etc/php/php.ini
    elif [ -f /etc/php5/php.ini ]; then
	sedit /etc/php5/php.ini
    elif [ -f /usr/bin/php5/bin/php.ini ]; then
	sedit /usr/bin/php5/bin/php.ini
    elif [ -f /etc/php5/apache2/php.ini ]; then
	sedit /etc/php5/apache2/php.ini
    else
	echo "Error: php.ini file could not be found."
	echo "Searching for possible locations:"
	sudo updatedb && locate php.ini
    fi
}

# Edit the MySQL configuration file
mysqlconfig() {
    if [ -f /etc/my.cnf ]; then
	sedit /etc/my.cnf
    elif [ -f /etc/mysql/my.cnf ]; then
	sedit /etc/mysql/my.cnf
    elif [ -f /usr/local/etc/my.cnf ]; then
	sedit /usr/local/etc/my.cnf
    elif [ -f /usr/bin/mysql/my.cnf ]; then
	sedit /usr/bin/mysql/my.cnf
    elif [ -f ~/my.cnf ]; then
	sedit ~/my.cnf
    elif [ -f ~/.my.cnf ]; then
	sedit ~/.my.cnf
    else
	echo "Error: my.cnf file could not be found."
	echo "Searching for possible locations:"
	sudo updatedb && locate my.cnf
    fi
}

# For some reason, rot13 pops up everywhere
rot13() {
    if [ $# -eq 0 ]; then
	tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    else
	echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    fi
}

# Trim leading and trailing spaces (for scripts)
trim() {
    local var=$@
    var="${var#"${var%%[![:space:]]*}"}"  # remove leading whitespace characters
    var="${var%"${var##*[![:space:]]}"}"  # remove trailing whitespace characters
    echo -n "$var"
}

#######################################################
# These functions are there for git configuration and
# download
#######################################################

function clone() {
    git clone git@github.com:cpp-rakesh/IntroductionToAlgorithmsCLRS.git
    git clone git@github.com:cpp-rakesh/ProjectEuler.git
    git clone git@github.com:cpp-rakesh/DiscreteMathematicsAndItsApplications.git
    git clone git@github.com:cpp-rakesh/LeetCode.git
    git clone git@github.com:cpp-rakesh/Algorithms.git
    git clone git@github.com:cpp-rakesh/HackerRank.git
    git clone git@github.com:cpp-rakesh/CodeChef.git
    git clone git@github.com:cpp-rakesh/TopCoder.git
    git clone git@github.com:cpp-rakesh/CodeForces.git
    git clone git@github.com:cpp-rakesh/Utility.git
    git clone git@github.com:cpp-rakesh/SPOJ.git
    git clone git@github.com:cpp-rakesh/Enviorenment.git
    git clone git@github.com:cpp-rakesh/Kattis.git
}

function pull() {
    cd ~/git_hub/IntroductionToAlgorithmsCLRS
    echo "***        Introduction to Algorithms          ***"
    git pull
    
    cd ~/git_hub/ProjectEuler
    echo "***                Project Euler               ***"
    git pull
    
    cd ~/git_hub/DiscreteMathematicsAndItsApplications
    echo "*** Discrete Mathematics And It's Applications ***"
    git pull    

    cd ~/git_hub/LeetCode
    echo "***                 Leet Code                  ***"
    git pull
    
    cd ~/git_hub/Algorithms
    echo "***                Algortithms                 ***"
    git pull
    
    cd ~/git_hub/HackerRank
    echo "***                Hacker Rank                 ***"
    git pull
    
    cd ~/git_hub/CodeChef
    echo "***                 Code Chef                  ***"
    git pull
    
    cd ~/git_hub/TopCoder
    echo "***                Top Coder                   ***"
    git pull
    
    cd ~/git_hub/CodeForces
    echo "***              Code Forces                   ***"
    git pull
    
    cd ~/git_hub/Utility
    echo "***                Utility                     ***"
    git pull
    
    cd ~/git_hub/SPOJ
    echo "***                  SPOJ                      ***"
    git pull
    
    cd ~/git_hub/Enviorenment
    echo "***               Enviorenment                 ***"
    git pull
    
    cd ~/git_hub/Kattis
    echo "***                 Kattis                     ***"
    git pull
    
    cd ~/git_hub    
}

function status() {
    echo "------------------------------------------------------"
    echo "Checking statuf of IntroductioToAlgorithms"
    cd ~/git_hub/IntroductionToAlgorithmsCLRS
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of ProjectEuler"
    cd ~/git_hub/ProjectEuler
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of DiscreteMathematicsAndItsApplications"
    cd ~/git_hub/DiscreteMathematicsAndItsApplications
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of LeetCode"
    cd ~/git_hub/LeetCode
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of Algorithms"
    cd ~/git_hub/Algorithms
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of HackerRank"
    cd ~/git_hub/HackerRank
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of CodeChef"
    cd ~/git_hub/CodeChef
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of TopCoder"
    cd ~/git_hub/TopCoder
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of CodeForces"
    cd ~/git_hub/CodeForces
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of Utility"
    cd ~/git_hub/Utility
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of SPOJ"
    cd ~/git_hub/SPOJ
    git status
    echo "------------------------------------------------------"

    echo "------------------------------------------------------"
    echo "Checking statuf of Enviorenment"
    cd ~/git_hub/Enviorenment
    git status
    cd ~/git_hub
    echo "------------------------------------------------------"
}

function git_config() {
    git config --global user.email "cpp.rakesh@gmail.com"
    git config --global user.name "Rakesh Kumar"   
}

function push() {
    git add *
    git commit -m $1
    git push
}

function set_prompt() {
    #  Customize BASH PS1 prompt to show current GIT repository and branch.

    #  SETUP CONSTANTS
    #  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
    #  I don't remember where I found this.  o_O

    # Reset
    Color_Off="\[\033[0m\]"       # Text Reset

    # Regular Colors
    Black="\[\033[0;30m\]"        # Black
    Red="\[\033[0;31m\]"          # Red
    Green="\[\033[0;32m\]"        # Green
    Yellow="\[\033[0;33m\]"       # Yellow
    Blue="\[\033[0;34m\]"         # Blue
    Purple="\[\033[0;35m\]"       # Purple
    Cyan="\[\033[0;36m\]"         # Cyan
    White="\[\033[0;37m\]"        # White

    # Bold
    BBlack="\[\033[1;30m\]"       # Black
    BRed="\[\033[1;31m\]"         # Red
    BGreen="\[\033[1;32m\]"       # Green
    BYellow="\[\033[1;33m\]"      # Yellow
    BBlue="\[\033[1;34m\]"        # Blue
    BPurple="\[\033[1;35m\]"      # Purple
    BCyan="\[\033[1;36m\]"        # Cyan
    BWhite="\[\033[1;37m\]"       # White

    # Underline
    UBlack="\[\033[4;30m\]"       # Black
    URed="\[\033[4;31m\]"         # Red
    UGreen="\[\033[4;32m\]"       # Green
    UYellow="\[\033[4;33m\]"      # Yellow
    UBlue="\[\033[4;34m\]"        # Blue
    UPurple="\[\033[4;35m\]"      # Purple
    UCyan="\[\033[4;36m\]"        # Cyan
    UWhite="\[\033[4;37m\]"       # White

    # Background
    On_Black="\[\033[40m\]"       # Black
    On_Red="\[\033[41m\]"         # Red
    On_Green="\[\033[42m\]"       # Green
    On_Yellow="\[\033[43m\]"      # Yellow
    On_Blue="\[\033[44m\]"        # Blue
    On_Purple="\[\033[45m\]"      # Purple
    On_Cyan="\[\033[46m\]"        # Cyan
    On_White="\[\033[47m\]"       # White

    # High Intensty
    IBlack="\[\033[0;90m\]"       # Black
    IRed="\[\033[0;91m\]"         # Red
    IGreen="\[\033[0;92m\]"       # Green
    IYellow="\[\033[0;93m\]"      # Yellow
    IBlue="\[\033[0;94m\]"        # Blue
    IPurple="\[\033[0;95m\]"      # Purple
    ICyan="\[\033[0;96m\]"        # Cyan
    IWhite="\[\033[0;97m\]"       # White

    # Bold High Intensty
    BIBlack="\[\033[1;90m\]"      # Black
    BIRed="\[\033[1;91m\]"        # Red
    BIGreen="\[\033[1;92m\]"      # Green
    BIYellow="\[\033[1;93m\]"     # Yellow
    BIBlue="\[\033[1;94m\]"       # Blue
    BIPurple="\[\033[1;95m\]"     # Purple
    BICyan="\[\033[1;96m\]"       # Cyan
    BIWhite="\[\033[1;97m\]"      # White

    # High Intensty backgrounds
    On_IBlack="\[\033[0;100m\]"   # Black
    On_IRed="\[\033[0;101m\]"     # Red
    On_IGreen="\[\033[0;102m\]"   # Green
    On_IYellow="\[\033[0;103m\]"  # Yellow
    On_IBlue="\[\033[0;104m\]"    # Blue
    On_IPurple="\[\033[10;95m\]"  # Purple
    On_ICyan="\[\033[0;106m\]"    # Cyan
    On_IWhite="\[\033[0;107m\]"   # White

    # Various variables you might want for your PS1 prompt instead
    Time12h="\T"
    Time12a="\@"
    PathShort="\w"
    PathFull="\W"
    NewLine="\n"
    Jobs="\j"

    export PS1="[$BBlue\d$Color_Off --> $BRed\u$Color_Off@$BBlack\w$Color_Off]: "

}

function friend_banner() {
    echo "8OOOOOOOOOZZ$$$Z$$7$Z8DDDDDDDDDD888OOOOOO8888DDDDDDDNNNDD8$III$ODD8888OOOOOZZZZO"
    echo "8OOOOOOOOOOOZ$$7II7Z8DDDDDDDDDDDDD888D88OOOO8DDDDDDNNNNNN8$III7ZDDDD888OOOOOZZZ8"
    echo "$777777777$ZZ$7I?I7O8O8DDDD88DDDDDDOOZO$$$$$$Z$ZZ8DOOOOOOZ$$Z$$ZZZOZZZZZZZZ$$$$8"
    echo "+++++++++++++++++++++??7$$$77$NDOZZZ7II7I$$III$7$$$8D++++++???++++++++++++++++?8"
    echo "++++++++++++=========+++????7NO$$7I?I????I7III??7IIZ7Z8===========~~~~~~~~~~~~~8"
    echo "+++++++++==================NN$$77II?II?????I??I+I?II7$Z8=~~~~~~~~~~~~~~::::::::N"
    echo "======~~~~~~~~~~~~~~~~~~~~DD8Z$77IIII?????++?++++??II$7OD:::::::,,,,,,,,,,,,,,,N"
    echo "~~~~~~~~~~~~~~~::::::::::ZNDOO$77IIII??+++++++++==++7?I$OD,,,,,,,,,,,,,,,,,,,,,M"
    echo "~~~~~~~~::::::::::::::::~NNDOZ$7777III??++=====+==+++++IZ8D,,,,,,,,,,,,,,,,,,,,M"
    echo "~~~~~~:::::::::::::::::~MNDO$Z$7$77IIII+++++=====~===++?$ZN+,,,,,,,,,,,,,,,,,,,M"
    echo "~~~~~~~::::::::::::::::=MZ$77I??++?7II++++++=+=========+IZND,,,,,,,,,,,,,,,,,,,M"
    echo "~~~~~~~~~~:::::::::::::MO7777I??+++?7$I?++=++???+===~~??7DNN,,,,,,,,,,,,,,,,,,,M"
    echo "~~~~~~~~~~~~~~~:::::::ID777$Z77I?I?I7$I?+~~~==?I7?====+?$MMN,,,,,,,,,,,,,,,,,,,M"
    echo "~~~~~~~~~~~~~~~~~~:::7N77IIIII$ZODNO7?++==~~=====+I?++I7ONNN,,,,,,,,,,,,,,,,,,,M"
    echo "~~~~~~==++???II??++::DZ7$7II????I7III++=====I++==~~=I?I8NNNZ,,,,,,,,,,,,,,,,,,,M"
    echo "~====+I7ODDNNNNNN+::~$$7777I??++??I+++====~+78+=~~~~==$NNNM:,,,,,,,,,,,,,,,,,,,M"
    echo "==+?IODDDNDDDDD8::::+8$777II?++=+I~Z?=::~=~=?=~+8=~~~+INNNN,,,,,,,,,,,,,,,,,,,,M"
    echo "+?IODDDD88OZ$$+:::::$$777II?++==?7?++===Z~=~=+=~=~=~~+IMNND,,,,,,,,,,,,,,,,,,,,M"
    echo "O8NNN8Z777$$7~::,::=7Z777II?+=+??III???+:==~===+=====+IND$$:,,,,,,,,,,,,,,,,,,,M"
    echo "NNNNDZ7III77~:::::~=$Z777I?++++??III?I++=====~===~===+I8$OZ~,,,,,,,,,,,,,,,,,,,M"
    echo "NNND8$7I777::::~~~~~ZO$77I??+++??I?+?====~=~~~~~=~==+?Z8N$O:,,,,,...,,,,,,,,,,,M"
    echo "ODNDO$77$7~::::::~~=Z8$$7I?+=~+ZZODO$Z+==~=~~~~=~~=+I7OZZ7+:,,,,,,,...,,,,,,,,,M"
    echo "?78D8Z$$I~::,,:::~=?I?Z$$7I?+=+???I7Z$$$+=~~~~~~~~=?$8ZO:,,,,,,,,,,,..,,,,,,,,,M"
    echo "+?ZN8ZZI~:::::=:?:+I?MM$Z$7I???+++=+?==?I?~~~:~~~=?7OZ8~?+~,,,,,,,,,,..,,,,,,,,M"
    echo "+?78OZ7~::~=====~:++MNNOZ$$777II???++====+=~~~~=+I$DI+:,,.=.,,,,,,,..,,.,:::,::M"
    echo "++??++~~====7I?::I=D8OO8OZZZ$$77?++=+=======~=+I7ZM:Z.I..,+.,,,,,,....,,,,::::~M"
    echo "I????==+:~7?:+,:=~77OMMN8OZ$OZ$7II?+==++++?II7$ZD7,?=+~..$Z=,,,,,..........:~++M"
    echo "O88O==+=8?~:?,ODOZO8O8O$888O$ZOZ$77I?II77$$$$Z8N8I,I,I,,:=,+=,,:,...........~??N"
    echo "OD8=++:+=::8=:?~:,?+:,,,~+7NNOZZZO8OO$777$ZODN7=~==.I,.+=,,Z7,:~,............+$N"
    echo "O8==?~:,:=?????+??,,.,,,,,.,:=+~,..=7ZZOODND$77I:,O$=~=..OZ,.,+=,........,,...+8"
    echo "O+++7=???II???++==,.,,..:+==+~...::.,~+?=?I=Z,DN8==~8:,..:,..~Z=:........,,....$"
    echo "++=O?8OOZZ7I~,,,,:ZO888OOOI,....,++,..=,+:+:,=+==,.I..Z7~,..:D:+........,,,,,..?"
    echo "++O?D7:,,,,,,,,.,?+?+~,.,.,..I$ZZOZ~,..=.,+??,~...+~.+.+=~~~~,?,+,......,,,,,..~"
    echo "ID$MDZOODNNMNNNNNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNMMMMMMNMNMMDMNMMNNDOO$7I?~~,"
}

set_prompt
git_config
friend_banner