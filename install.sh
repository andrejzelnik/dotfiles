#!/usr/bin/env zsh
# From-scratch macOS setup script

set -e

DOTFILES_REPO="https://github.com/andrejzelnik/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

info()    { print -P "%F{blue}==>%f %B$1%b" }
success() { print -P "%F{green}✓%f $1" }
error()   { print -P "%F{red}✗%f $1" >&2; exit 1 }

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

  echo >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
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
ln -sf "$DOTFILES_DIR/.zimrc"            ~/.zimrc
ln -sf "$DOTFILES_DIR/.zshrc"            ~/.zshrc
ln -sf "$DOTFILES_DIR/.gitconfig"        ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitignore_global" ~/.gitignore_global
ln -sf "$DOTFILES_DIR/.tmux.conf"        ~/.tmux.conf
ln -sf "$DOTFILES_DIR/macos.sh"          ~/macos.sh
touch ~/.gitconfig.local   # must exist before any git command reads .gitconfig

# SSH config — only link if no existing config
if [[ ! -f ~/.ssh/config ]]; then
  mkdir -p ~/.ssh && chmod 700 ~/.ssh
  ln -sf "$DOTFILES_DIR/.ssh/config" ~/.ssh/config
  chmod 600 ~/.ssh/config
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
  ln -sf "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"

  grep -v '^#' "$DOTFILES_DIR/vscode/extensions.txt" | grep -v '^$' | while read ext; do
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
if [[ -z $(git config user.name) ]]; then
  print -n "Git name:  "; read git_name < /dev/tty
  print -n "Git email: "; read git_email < /dev/tty
  print "[user]\n\tname = $git_name\n\temail = $git_email" >> ~/.gitconfig.local
fi

# Set zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
  chsh -s /bin/zsh
fi

success "Done! Restart your terminal."
print ""
print "Optional:  ~/macos.sh          — apply macOS system defaults"
print "To update: git -C ~/.dotfiles pull"
