# dotfiles

Customized dotfiles and base tools for macOS (Apple Silicon).

## Quick start

```sh
curl -fsSL https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/install.sh | zsh
```

Or follow the manual steps below.

---

## Manual setup

### 1. Xcode Command Line Tools

```sh
xcode-select --install
```

### 2. Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
```

### 3. Zim (zsh framework)

```sh
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

### 4. Dotfiles

Clone the repo and symlink everything into place:

```sh
git clone https://github.com/andrejzelnik/dotfiles ~/.dotfiles

ln -sf ~/.dotfiles/.zimrc            ~/.zimrc
ln -sf ~/.dotfiles/.zshrc            ~/.zshrc
ln -sf ~/.dotfiles/.gitconfig        ~/.gitconfig
ln -sf ~/.dotfiles/.gitignore_global ~/.gitignore_global
ln -sf ~/.dotfiles/.tmux.conf        ~/.tmux.conf

# Starship prompt config
mkdir -p ~/.config
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml

# mise language version manager config
mkdir -p ~/.config/mise
ln -sf ~/.dotfiles/.mise.toml ~/.config/mise/config.toml

# Required by .gitconfig (stores your name/email, not tracked)
touch ~/.gitconfig.local

# SSH config (skip if you already have one)
mkdir -p ~/.ssh && chmod 700 ~/.ssh
ln -sf ~/.dotfiles/.ssh/config ~/.ssh/config && chmod 600 ~/.ssh/config
```

### 5. Install tools

```sh
brew bundle --file=~/.dotfiles/Brewfile
```

### 6. Zim modules

```sh
zimfw install
```

### 7. VS Code

```sh
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"
ln -sf ~/.dotfiles/vscode/settings.json "$VSCODE_USER_DIR/settings.json"

grep -v '^#' ~/.dotfiles/vscode/extensions.txt | grep -v '^$' | while read ext; do
  code --install-extension "$ext" --force
done
```

### 8. Post-install

```sh
# Git identity (stored in ~/.gitconfig.local, not tracked by dotfiles)
git config -f ~/.gitconfig.local user.name  "Your Name"
git config -f ~/.gitconfig.local user.email "you@example.com"

# Set zsh as default shell
chsh -s /bin/zsh

# TPM — install tmux plugins (run inside a tmux session)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# then press prefix + Ctrl-I inside tmux to fetch plugins
```

### 9. macOS defaults (optional)

```sh
make macos
# or: zsh ~/.dotfiles/macos.sh
```

## Makefile targets

| Target | Description |
|--------|-------------|
| `make install` | Full setup from scratch |
| `make update` | Pull latest + reinstall brew packages + zim modules |
| `make link` | Re-link dotfiles only |
| `make macos` | Apply macOS system defaults |
| `make lint` | Run shellcheck on all shell scripts |

## Updating

```sh
git -C ~/.dotfiles pull
# or: make update
```

Symlinks mean changes take effect immediately — no re-running the install script.

---

## What's installed

| Category | Tools |
|---|---|
| Shell | zsh, Zim, Starship prompt |
| Terminal | tmux, bash-completion, fzf, zoxide, bat |
| Cloud | azure-cli, awscli, kubectl, helm, k9s, kubectx, sops |
| IaC | terraform, vault, terragrunt, tflint, infracost |
| Data | jq, yq, duckdb, libpq (psql), mssql-tools18 |
| Development | gh, pre-commit, git-delta, mise, typst, shellcheck, starship |
| Security | gnupg |
| Apps | VS Code, Claude Code |
