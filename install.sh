#!/usr/bin/env zsh
# From-scratch macOS setup script

set -e

DOTFILES_REPO="https://github.com/andrejzelnik/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

info()    { print -P "%F{blue}==>%f %B$1%b"; }
success() { print -P "%F{green}✓%f $1"; }
error()   { print -P "%F{red}✗%f $1" >&2; exit 1; }

# Back up existing file (if it's a real file, not already a symlink) then symlink
link_file() {
  local src="$1" dst="$2"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/$(basename "$dst").$(date +%s)"
    info "Backed up $dst → $BACKUP_DIR/"
  fi
  ln -sf "$src" "$dst"
}

# ── 1. Xcode Command Line Tools ───────────────────────────────────────────────
info "Checking Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  print "Please complete the Xcode CLT installation, then re-run this script."
  exit 0
fi
success "Xcode CLT installed"

# ── 2. Homebrew ───────────────────────────────────────────────────────────────
info "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
    echo >> ~/.zprofile
    # shellcheck disable=SC2016
    echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
  fi
fi
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
success "Homebrew ready"

# ── 3. Zim ────────────────────────────────────────────────────────────────────
info "Checking Zim..."
if [[ ! -d ${ZIM_HOME:-~/.zim} ]]; then
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
fi
success "Zim ready"

# ── 4. Dotfiles ───────────────────────────────────────────────────────────────
info "Syncing dotfiles repo..."
if [[ ! -d "$DOTFILES_DIR" ]]; then
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull
fi

info "Linking dotfiles..."
link_file "$DOTFILES_DIR/.zimrc"            ~/.zimrc
link_file "$DOTFILES_DIR/.zshrc"            ~/.zshrc
link_file "$DOTFILES_DIR/.gitconfig"        ~/.gitconfig
link_file "$DOTFILES_DIR/.gitignore_global" ~/.gitignore_global
link_file "$DOTFILES_DIR/.tmux.conf"        ~/.tmux.conf

# Starship config
mkdir -p ~/.config
link_file "$DOTFILES_DIR/starship.toml" ~/.config/starship.toml

# mise config
mkdir -p ~/.config/mise
link_file "$DOTFILES_DIR/.mise.toml" ~/.config/mise/config.toml

# SSH config — only link if no existing config
if [[ ! -f ~/.ssh/config ]]; then
  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  ln -sf "$DOTFILES_DIR/.ssh/config" ~/.ssh/config
  chmod 600 ~/.ssh/config
fi

# Git identity (stored in ~/.gitconfig.local, not tracked)
if [[ ! -f ~/.gitconfig.local ]]; then
  touch ~/.gitconfig.local
fi
success "Dotfiles linked"

# ── 5. Tools via Brewfile ─────────────────────────────────────────────────────
info "Installing tools via Brewfile..."
HOMEBREW_ACCEPT_EULA=Y brew bundle --file="$DOTFILES_DIR/Brewfile"
success "Tools installed"

# ── 6. Zim modules ────────────────────────────────────────────────────────────
info "Installing Zim modules..."
export ZIM_HOME="${ZIM_HOME:-$HOME/.zim}"
source ~/.zshrc 2>/dev/null || true
zimfw install
success "Zim modules installed"

# ── 7. VS Code ────────────────────────────────────────────────────────────────
info "Configuring VS Code..."
if command -v code &>/dev/null; then
  VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
  mkdir -p "$VSCODE_USER_DIR"
  link_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"

  grep -v '^#' "$DOTFILES_DIR/vscode/extensions.txt" | grep -v '^$' | while read -r ext; do
    code --install-extension "$ext" --force 2>/dev/null || true
  done
  success "VS Code configured"
else
  success "VS Code not found, skipping (install and rerun to configure)"
fi

# ── 8. Post-install ───────────────────────────────────────────────────────────
info "Running post-install steps..."

# TPM (tmux plugin manager)
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Git identity (stored in ~/.gitconfig.local, not tracked by dotfiles)
if [[ -z $(git config user.name 2>/dev/null) ]]; then
  print -n "Git name:  "; read -r git_name < /dev/tty
  print -n "Git email: "; read -r git_email < /dev/tty
  git config -f ~/.gitconfig.local user.name "$git_name"
  git config -f ~/.gitconfig.local user.email "$git_email"
fi

# Set zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
  chsh -s /bin/zsh
fi

success "Done! Restart your terminal."

# ── 9. macOS defaults (optional) ──────────────────────────────────────────────
print ""
print -n "Apply macOS system defaults? (Dock, Finder, keyboard) [y/N] "
read -r reply < /dev/tty
if [[ "$reply" =~ ^[Yy]$ ]]; then
  zsh "$DOTFILES_DIR/macos.sh"
  success "macOS defaults applied"
else
  print "Skipped. Run 'make macos' later to apply."
fi

print ""
print "To update: git -C ~/.dotfiles pull  (or 'make update')"
