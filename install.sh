#!/bin/bash

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim

echo -e "\nsource ~/dotfiles/bashrc\n" &>> ~/.profile

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
