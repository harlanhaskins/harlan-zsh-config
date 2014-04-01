# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fishy"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx zsh-syntax-highlighting brew)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
#

# setup zsh-autosuggestions
source ~/.zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^T' autosuggest-toggle

#
# Make sure SSH fowards certain environment variables
# so that we know the used operating system on remote terminals too.
#
# Note - you need forward these envs in /etc/sudoers too
#
# sudo nano /etc/sudoers
# Defaults    env_keep+=LC_TERM_PROGRAM
#

# http://groups.google.com/group/iterm2-discuss/msg/7cc214c487d31bc8
# We need to use LC_ named environment variable
# as looks like Ubuntu hosts are configured to pass in thru by default -
# all other SendEnv forwards are being ignored
# in /etc/ssh/sshd_config
FORWARD_TERM="SendEnv LC_TERM_PROGRAM"

CONFIG=~/.ssh/config

# Make sure we have ~/.ssh/config
if [ ! -e ~/.ssh ] ; then
       mkdir ~/.ssh
fi

if [ ! -e "$CONFIG" ] ; then
       touch "$CONFIG"
fi

# Make sure our SendEnv forwards are in place in ssh config
grep "$FORWARD_TERM" "$CONFIG" >/dev/null

if [ $? -eq 1 ] ; then
       CONTENT=$(cat $CONFIG) # no cat abuse this time
       echo -en "$FORWARD_TERM\n\n$CONTENT" > $CONFIG
fi

# Export our terminal (iTerm 2)
[[ "$TERM_PROGRAM" != "" ]] && export LC_TERM_PROGRAM="$TERM_PROGRAM"

# Mac keyboard specific keybindings
if [[ "$LC_TERM_PROGRAM" == "iTerm.app" ]] ; then

       bindkey "\e\e[D" backward-word # alt + <-
       bindkey "\e\e[C" forward-word # alt + ->

       bindkey '^[[H' beginning-of-line
       bindkey '^[[F' end-of-line

fi

# return my IP address
function myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
     ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
     ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
     ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
     ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# Custom macros of mine.
export THEOS=/opt/bin/theos
export THEOS_DEVICE_IP=192.168.1.4

export CODE_DIR=~/Documents/Code
export IOS_DIR=$CODE_DIR/Objective-C/iOS
export BRYX_DIR=$IOS_DIR/Bryx/Bryx\ 911
export JAILBREAK_DIR=$IOS_DIR/Jailbreak

export CSH_SSH=harlan@rancor.csh.rit.edu

export SITE_DIR=$CODE_DIR/Web/Personal-Site

# aliases
alias sshcsh='mosh harlan@rancor.csh.rit.edu'
