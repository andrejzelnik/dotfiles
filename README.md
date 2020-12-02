# dotfiles

Customized dotfiles and installation of base tools for my local environment.

## tools installation

```sh
softwareupdate --install-rosetta

# === base tools for terminal ==================================================
# install Homebrew - package manager for macOS (https://brew.sh/)
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update

# install antigen - plugin manager for zsh (https://antigen.sharats.me/)
arch -x86_64 brew install antigen

# install oh-my-zsh - framework for zsh configuration (https://ohmyz.sh/)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install nerd fonts (https://github.com/ryanoasis/nerd-fonts)
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
# ad-hoc font installation
cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# install powerlevel10k (https://github.com/romkatv/powerlevel10k)
arch -x86_64 brew install romkatv/powerlevel10k/powerlevel10k

# install bash completion
arch -x86_64 brew install bash-completion

# install tmux - terminal multiplexer (https://github.com/tmux/tmux/wiki)
arch -x86_64 brew install tmux

# === other tools ==============================================================
# install azure-cli (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos)
arch -x86_64 brew install azure-cli

# install helm (https://helm.sh/docs/intro/install/)
arch -x86_64 brew install helm

# install jq (https://formulae.brew.sh/formula/jq)
arch -x86_64 brew install jq

# install kubernetes cli (https://kubernetes.io/docs/tasks/tools/install-kubectl/)
arch -x86_64 brew install kubectl

# install terraform cli (https://learn.hashicorp.com/tutorials/terraform/install-cli)
brew tap hashicorp/tap
arch -x86_64 brew install hashicorp/tap/terraform
terraform -install-autocomplete

# install sql server cli (https://cloudblogs.microsoft.com/sqlserver/2017/05/16/sql-server-command-line-tools-for-macos-released/)
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
arch -x86_64 brew install msodbcsql mssql-tools
```

## usage

```sh
# copy dotfiles
cd ~/
curl -fLo ".antigenrc" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.antigenrc
curl -fLo ".p10k.zsh" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.p10k.zsh
curl -fLo ".zshrc" https://raw.githubusercontent.com/andrejzelnik/dotfiles/master/.zshrc
# to use zsh run
chsh -s /bin/zsh
```

modify Terminal > Preferences > Font & Window size
