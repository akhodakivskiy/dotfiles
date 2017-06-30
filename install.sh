#!/bin/bash

ln -snf ~/dotfiles/vimrc ~/.vimrc
ln -snf ~/dotfiles/vim ~/.vim
ln -snf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -snf ~/dotfiles/tmux-linux.conf ~/.tmux-linux.conf

# Vundle for vim
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ] ; then
  git clone https://github.com/gmarik/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi

# TPM for tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ] ; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "done!"
