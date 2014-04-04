#!/bin/zsh

# Move to directory of script
OLDDIR=`pwd`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# Backup olf zsh config
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.old
fi;

if [ -d ~/.oh-my-zsh ]; then
    rm -rf ~/.oh-my-zsh
fi;

# install Oh My ZSH
curl -L http://install.ohmyz.sh | sh

source ~/.zshrc

# Remove Oh-My-ZSH default zshrc.
rm ~/.zshrc

git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

if [ -d ~/.zsh-autosuggestions ]; then
    git clone git://github.com/tarruda/zsh-autosuggestions ~/.zsh-autosuggestions
fi;

# Create a hard link between this zshrc and the actual zshrc file.
ln -F .zshrc ~/

source ~/.zshrc

cd $OLDDIR
