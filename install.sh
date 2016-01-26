#!/bin/bash

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

echo -e "\nsource ~/dotfiles/bashrc\n" >> ~/.profile

# Vundle for vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# TPM for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
