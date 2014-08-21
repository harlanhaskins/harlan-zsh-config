export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(git zsh-syntax-highlighting)
ZSH_THEME="fishy"

# User configuration
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"


#Virtualenv Wrapper
source /usr/bin/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# http://groups.google.com/group/iterm2-discuss/msg/7cc214c487d31bc8
# We need to use LC_ named environment variable
# as looks like Ubuntu hosts are configured to pass in thru by default -
# all other SendEnv forwards are being ignored
# in /etc/ssh/sshd_config
FORWARD_TERM="SendEnv LC_TERM_PROGRAM"

SSH_CONFIG=~/.ssh/config

# Make sure we have ~/.ssh/config
if [ ! -e ~/.ssh ] ; then
       mkdir ~/.ssh
fi

if [ ! -e "$SSH_CONFIG" ] ; then
       touch "$SSH_CONFIG"
fi

# Make sure our SendEnv forwards are in place in ssh config
grep "$FORWARD_TERM" "$SSH_CONFIG" >/dev/null

if [ $? -eq 1 ] ; then
       CONTENT=$(cat $SSH_CONFIG) # no cat abuse this time
       echo -en "$FORWARD_TERM\n\n$CONTENT" > $SSH_CONFIG
fi

# Export our terminal (iTerm 2)
[[ "$TERM_PROGRAM" != "" ]] && export LC_TERM_PROGRAM="$TERM_PROGRAM"

# Mac keyboard specific keybindings
# if [[ "$LC_TERM_PROGRAM" == "iTerm.app" ]] ; then

       bindkey "\e\e[D" backward-word # alt + <-
       bindkey "\e\e[C" forward-word # alt + ->

       bindkey '^[[H' beginning-of-line
       bindkey '^[[F' end-of-line

# fi
