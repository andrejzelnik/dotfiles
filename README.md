# dotfiles

Customized dotfiles and installation of base tools for my local environment.

## tools installation

```sh
softwareupdate --install-rosetta

# === base tools for terminal ==================================================
# install Homebrew - package manager for macOS (https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

brew update

# install Zim - framework for zsh (https://zimfw.sh/)
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# install nerd fonts (https://github.com/ryanoasis/nerd-fonts)
brew install --cask font-hack-nerd-font
brew install --cask font-droid-sans-mono-nerd-font

# install bash completion
brew install bash-completion

# install tmux - terminal multiplexer (https://github.com/tmux/tmux/wiki)
brew install tmux

# === other tools ==============================================================
# install azure-cli (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos)
brew install azure-cli

# install helm (https://helm.sh/docs/intro/install/)
brew install helm

# install jq (https://formulae.brew.sh/formula/jq)
brew install jq

# install kubernetes cli (https://kubernetes.io/docs/tasks/tools/install-kubectl/)
brew install kubectl

# install terraform cli (https://developer.hashicorp.com/terraform/install)
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -install-autocomplete

# install terragrunt cli (https://terragrunt.gruntwork.io/docs/getting-started/install/)
brew install terragrunt

# install sql server cli (https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools)
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
brew install msodbcsql18 mssql-tools18

# install postgresql server cli
brew install libpq

# install aws-cli (https://formulae.brew.sh/formula/awscli)
brew install awscli

# install gnupg (https://formulae.brew.sh/formula/gnupg)
brew install gnupg
```

## usage

```sh
# copy dotfiles
cd ~/
curl -fLo ".zimrc" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.zimrc
curl -fLo ".p10k.zsh" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.p10k.zsh
curl -fLo ".zshrc" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.zshrc
# to use zsh run
chsh -s /bin/zsh
```

modify Terminal > Settings > Profiles >> (Default) >> Font & Window size
