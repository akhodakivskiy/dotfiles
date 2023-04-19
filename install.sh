#!/bin/bash

ln -snf ~/dotfiles/vimrc ~/.vimrc
ln -snf ~/dotfiles/vim ~/.vim
ln -snf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -snf ~/dotfiles/tmux-linux.conf ~/.tmux-linux.conf

mkdir -p ~/.vim/undo
mkdir -p ~/.vim/swap

# Vundle for vim
if [ ! -d "$HOME/.vim/autoload/plug.vim" ] ; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# TPM for tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ] ; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "done!"
