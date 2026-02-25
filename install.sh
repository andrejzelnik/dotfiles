#!/usr/bin/env zsh
# From-scratch macOS setup script

set -e

DOTFILES_RAW="https://raw.githubusercontent.com/andrejzelnik/dotfiles/master"

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
info "Downloading dotfiles..."
curl -fsSL -o ~/.zimrc     "$DOTFILES_RAW/.zimrc"
curl -fsSL -o ~/.zshrc    "$DOTFILES_RAW/.zshrc"
curl -fsSL -o ~/.gitconfig "$DOTFILES_RAW/.gitconfig"
curl -fsSL -o ~/.tmux.conf "$DOTFILES_RAW/.tmux.conf"
success "Dotfiles downloaded"

# ── 5. Tools via Brewfile ─────────────────────────────────────────────────────
info "Installing tools via Brewfile..."
curl -fsSL -o /tmp/Brewfile "$DOTFILES_RAW/Brewfile"
brew bundle --file=/tmp/Brewfile
success "Tools installed"

# ── 6. Zim modules ───────────────────────────────────────────────────────────
info "Installing Zim modules..."
source ~/.zshrc 2>/dev/null || true
zimfw install
success "Zim modules installed"

# ── 7. Post-install ───────────────────────────────────────────────────────────
info "Running post-install steps..."

# Terraform shell completion (idempotent)
if command -v terraform &>/dev/null; then
  terraform -install-autocomplete 2>/dev/null || true
fi

# Set zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
  chsh -s /bin/zsh
fi

success "Done! Restart your terminal."
