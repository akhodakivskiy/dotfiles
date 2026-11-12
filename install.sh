#!/usr/bin/env bash
# Install dotfiles on macOS or Linux. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"

info() { printf '==> %s\n' "$*"; }
warn() { printf 'WARNING: %s\n' "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

# link <path in repo> <destination>
# Replaces an existing symlink; never touches a real file or directory.
link() {
  local src="$DOTFILES/$1" dst="$2"
  if [ -L "$dst" ]; then
    if [ "$(readlink "$dst")" = "$src" ]; then
      return 0
    fi
    rm "$dst"
  elif [ -e "$dst" ]; then
    warn "$dst exists and is not a symlink; skipped. Move it away and re-run."
    return 0
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  info "linked $dst"
}

# clone <url> <destination>, only if missing
clone() {
  if [ ! -d "$2" ]; then
    info "cloning $1"
    git clone --quiet --depth 1 "$1" "$2"
  fi
}

# ------------- prerequisites --------------

for cmd in git curl; do
  have "$cmd" || { echo "ERROR: $cmd is required" >&2; exit 1; }
done
for cmd in zsh nvim tmux kitty rg fzf; do
  have "$cmd" || warn "$cmd not found; install it, then re-run"
done

mkdir -p "$HOME/bin"

# ------------- symlinks --------------

info "linking configs"
link vimrc "$HOME/.vimrc"
link vim "$HOME/.vim"
link nvim "$CONFIG/nvim"
link tmux.conf "$HOME/.tmux.conf"
link kitty "$CONFIG/kitty"
link zshrc-common "$HOME/.zshrc-common"
link gitconfig "$HOME/.gitconfig"
link git/ignore "$CONFIG/git/ignore"

case "$OS" in
  Linux) link i3 "$CONFIG/i3" ;;
esac

# ------------- vim --------------

if have vim; then
  if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    info "installing vim-plug"
    curl -fsSLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  info "installing vim plugins"
  vim -N -es -u "$HOME/.vimrc" -i NONE +'PlugInstall --sync' +qa || warn "vim plugin install failed"
fi

# ------------- neovim --------------

if have nvim; then
  info "installing neovim plugins"
  nvim --headless "+Lazy! install" +qa || warn "neovim plugin install failed"
fi

# ------------- tmux --------------

if have tmux; then
  clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  info "installing tmux plugins"
  "$HOME/.tmux/plugins/tpm/bin/install_plugins" || warn "tmux plugin install failed"
fi

# ------------- zsh --------------

if have zsh; then
  OMZ="${ZSH:-$HOME/.oh-my-zsh}"
  if [ ! -d "$OMZ" ]; then
    info "installing oh-my-zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  ZSH_PLUGINS="${ZSH_CUSTOM:-$OMZ/custom}/plugins"
  clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS/zsh-autosuggestions"
  clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_PLUGINS/zsh-syntax-highlighting"

  # ~/.zshrc stays machine-local; it only has to source the shared part.
  # The line must sit before oh-my-zsh.sh is sourced (so zshrc-common can add
  # plugins); without oh-my-zsh in ~/.zshrc it goes at the end.
  ZSHRC="$HOME/.zshrc"
  OMZ_RE='^[[:space:]]*(source|[.])[[:space:]].*oh-my-zsh[.]sh'
  touch "$ZSHRC"
  common_ln="$(grep -n 'zshrc-common' "$ZSHRC" | grep -Ev '^[0-9]+:[[:space:]]*#' | head -n 1 | cut -d: -f1 || true)"
  omz_ln="$(grep -nE "$OMZ_RE" "$ZSHRC" | head -n 1 | cut -d: -f1 || true)"
  if [ -z "$common_ln" ] || { [ -n "$omz_ln" ] && [ "$common_ln" -gt "$omz_ln" ]; }; then
    info "adding ~/.zshrc-common to ~/.zshrc (backup: ~/.zshrc.pre-dotfiles)"
    cp "$ZSHRC" "$ZSHRC.pre-dotfiles"
    SOURCE_LINE='[[ -r "$HOME/.zshrc-common" ]] && . "$HOME/.zshrc-common"' \
      awk -v omz="$OMZ_RE" '
        /zshrc-common/ && !/^[[:space:]]*#/ { next }
        !done && $0 ~ omz { print ENVIRON["SOURCE_LINE"]; print ""; done = 1 }
        { print }
        END { if (!done) { print ""; print ENVIRON["SOURCE_LINE"] } }
      ' "$ZSHRC.pre-dotfiles" >"$ZSHRC.tmp"
    cat "$ZSHRC.tmp" >"$ZSHRC" # keeps ~/.zshrc a symlink if it is one
    rm "$ZSHRC.tmp"
  fi
fi

info "done"
