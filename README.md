# dotfiles
my customized dotfiles

## install requirements

```sh
# === base tools for terminal ==================================================
# install Homebrew - package manager for macOS (https://brew.sh/)
cd /usr/local && mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew

brew update

# install antigen - plugin manager for zsh (https://antigen.sharats.me/)
brew install antigen

# install oh-my-zsh - framework for zsh configuration (https://ohmyz.sh/)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install nerd fonts (https://github.com/ryanoasis/nerd-fonts)
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
# ad-hoc font installation
cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# install powerlevel10k (https://github.com/romkatv/powerlevel10k)
brew install romkatv/powerlevel10k/powerlevel10k

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

# install sql server cli (https://cloudblogs.microsoft.com/sqlserver/2017/05/16/sql-server-command-line-tools-for-macos-released/)
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
brew install msodbcsql mssql-tools
```

## usage

```sh
# copy dotfiles
cp .antigenrc ~/
cp .p10k.zsh ~/
cp .zshrc ~/
# to use zsh run
chsh -s /bin/zsh
```