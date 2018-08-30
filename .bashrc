# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set an additional PATH to an distribution specific bin dir
OS="OS"
if [ -f /etc/os-release ]; then
	OS=$(source /etc/os-release; echo $ID$VERSION)
elif [ -f /etc/SuSE-release ]; then
	OS="sles$(awk '/VERSION/{print $3}'</etc/SuSE-release )"
fi

if [ "$OS" != "OS" ] && ! echo "$PATH" | grep -q "$HOME/bin/$OS:" ; then
	export PATH=$HOME/bin/$OS:$PATH
fi

# try switching to zsh, which is defined by our PATH
if [ -z "$NOZSH" ] && which zsh >/dev/null 2>&1; then
	case $- in
		*i*) exec zsh;;
	esac
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# History-Options
export HISTFILESIZE=5000000
export HISTSIZE=5000000
export HISTCONTROL="ignoredups"
shopt -s histappend

export NSS_DEFAULT_DB_TYPE="sql"

export PATH=$PATH:/sbin:~/bin/installs/android-sdk-linux_x86/platform-tools

alias mutt='echo -ne "\033]0;mutt:${USER}@`hostname`\007";mutt'
alias NewMailboxes="find ~/Maildir/ -name '*:2,' -exec dirname {} \; | uniq"

alias newmail="vim -c 'set textwidth=75' -c 'set filetype=mail'"

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
