#!/bin/bash

# oh-my-zsh

# ------------- vim --------------

echo "*1 installing vim config"
ln -snf ~/dotfiles/vimrc ~/.vimrc
ln -snf ~/dotfiles/vim ~/.vim
ln -snf ~/dotfiles/alacritty.toml ~/.alacritty.toml

# vim-plug
echo "installing vim-plug"
if [ ! -d "$HOME/.vim/autoload/plug.vim" ]; then
  mkdir -p ~/.vim/autoload/
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "WARNING: ~/.vim/autoload/plug.vim already exists"
fi

# vim plugins
echo "installing vim plugins"
vim +'PlugInstall --sync' +qa

# ------------- neovim --------------
#
echo "*2 installing neovim config"
if [ ! -d "$HOME/.config/nvim" ]; then
  ln -snf ~/dotfiles/nvim ~/.config/nvim
else
  echo "WARNING: ~/.config/nvim already exists"
fi

echo "installing neovim plugins"
nvim --headless "+Lazy! sync" +qa

# ------------- tmux --------------
#
echo "*3 installing tmux config"
if [ ! -f "$HOME/.tmux.conf" ]; then
  ln -snf ~/dotfiles/tmux.conf ~/.tmux.conf
else
  echo "WARNING: ~/.tmux.conf already exists"
fi

echo "installing tmux tpm"
# TPM for tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "WARNING: ~/.tmux/plugins/tpm already exists"
fi

echo "installing tmux tpm plugins"
source "$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo "done!"
