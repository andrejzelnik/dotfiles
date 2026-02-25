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
ln -sf ~/.dotfiles/macos.sh          ~/macos.sh

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

### 7. Post-install

```sh
# Terraform shell completion
terraform -install-autocomplete

# Set zsh as default shell
chsh -s /bin/zsh

# TPM — install tmux plugins (run inside a tmux session)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# then press prefix + Ctrl-I inside tmux to fetch plugins
```

### 8. macOS defaults (optional)

```sh
~/macos.sh
```

## Updating

```sh
git -C ~/.dotfiles pull
```

Symlinks mean changes take effect immediately — no re-running the install script.

---

## What's installed

| Category | Tools |
|---|---|
| Shell | zsh, Zim (eriner theme) |
| Terminal | tmux, bash-completion, fzf, zoxide, bat |
| Cloud | azure-cli, awscli, kubectl, helm, k9s, kubectx, sops |
| IaC | terraform, vault, terragrunt, tflint, infracost |
| Data | jq, yq, duckdb, libpq (psql), mssql-tools18 |
| Development | gh, pre-commit, git-delta |
| Security | gnupg |
| Apps | Claude Code |
