#!/usr/bin/env zsh
# Symlink dotfiles into $HOME — safe to re-run; backs up real files first

set -e

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")" && pwd)}"
BACKUP_DIR="$HOME/.dotfiles-backup"

# Back up existing file (if it's a real file, not already a symlink) then symlink
link_file() {
  local src="$1" dst="$2"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/$(basename "$dst").$(date +%s)"
    print "Backed up $dst → $BACKUP_DIR/"
  fi
  ln -sf "$src" "$dst"
}

link_file "$DOTFILES_DIR/.zimrc"            ~/.zimrc
link_file "$DOTFILES_DIR/.zshrc"            ~/.zshrc
link_file "$DOTFILES_DIR/.gitconfig"        ~/.gitconfig
link_file "$DOTFILES_DIR/.gitignore_global" ~/.gitignore_global
link_file "$DOTFILES_DIR/.tmux.conf"        ~/.tmux.conf

mkdir -p ~/.config
link_file "$DOTFILES_DIR/starship.toml" ~/.config/starship.toml

mkdir -p ~/.config/mise
link_file "$DOTFILES_DIR/.mise.toml" ~/.config/mise/config.toml

mkdir -p ~/.config/atuin
link_file "$DOTFILES_DIR/atuin/config.toml" ~/.config/atuin/config.toml

# SSH config — only link if no existing config
if [[ ! -f ~/.ssh/config ]]; then
  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  ln -sf "$DOTFILES_DIR/.ssh/config" ~/.ssh/config
  chmod 600 ~/.ssh/config
fi

# Git identity (stored in ~/.gitconfig.local, not tracked)
[[ -f ~/.gitconfig.local ]] || touch ~/.gitconfig.local

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
if command -v code &>/dev/null || [[ -d "$VSCODE_USER_DIR" ]]; then
  mkdir -p "$VSCODE_USER_DIR"
  link_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
fi
