#!/bin/bash

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

PROFILE_FILE=$1

if [ -z "$PROFILE_FILE" ]; then
    PROFILE_FILE="$HOME/.profile"
fi

echo "adding to ${PROFILE_FILE}"

echo -e "\nsource ~/dotfiles/bashrc\n" >> "$PROFILE_FILE"

# Vundle for vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# TPM for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "done!"
