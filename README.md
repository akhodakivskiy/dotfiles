# dotfiles

Personal config for macOS and Linux.

| Path | What |
|---|---|
| `nvim/` | Neovim (LazyVim) |
| `vimrc`, `vim/` | Vim fallback (vim-plug) |
| `kitty/` | kitty terminal |
| `tmux.conf` | tmux (plugins via tpm) |
| `zshrc-common` | Shared zsh config |
| `gitconfig`, `git/ignore` | Git config and global ignore |
| `i3/` | i3 + i3status-rust (Linux only) |

## Install

```sh
git clone git@github.com:akhodakivskiy/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` is safe to re-run. It symlinks the configs, installs plugin
managers and plugins (vim-plug, lazy.nvim, tpm, oh-my-zsh), and adds the
`zshrc-common` source line to `~/.zshrc`. It never replaces a real file: if a
destination already exists and is not a symlink, it warns and skips it.

Install these first: `git`, `curl`, `zsh`, `nvim`, `tmux`, `kitty`, `rg`,
`fd`, `fzf`, a C compiler, and the 0xProto Nerd Font.

## Machine-local settings

These stay out of the repo:

| File | For |
|---|---|
| `~/.zshrc` | Everything machine-specific. Sources `~/.zshrc-common` just before `oh-my-zsh.sh`; extra plugins go in `plugins=(...)` above that line. |
| `kitty/local.conf` | kitty overrides such as font size (gitignored) |
| `~/.gitconfig-local` | Git overrides such as a work email |
