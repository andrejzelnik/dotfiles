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

```sh
cd ~/
curl -fLo ".zimrc"  https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.zimrc
curl -fLo ".zshrc" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.zshrc
```

### 5. Install tools

```sh
curl -fLo "Brewfile" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/Brewfile
brew bundle
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
```

---

## What's installed

| Category | Tools |
|---|---|
| Shell | zsh, Zim (eriner theme) |
| Terminal | tmux, bash-completion |
| Cloud | azure-cli, awscli, kubectl, helm |
| IaC | terraform, terragrunt |
| Data | jq, libpq (psql), mssql-tools18 |
| Security | gnupg |
| Apps | Claude Code |
