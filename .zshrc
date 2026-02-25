DEFAULT_USER=$(whoami)

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY

# Editor
export EDITOR=vim
export VISUAL=vim

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# start Zim
source ${ZIM_HOME:-~/.zim}/init.zsh

# enable azure-cli completion
autoload -U +X bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az

# libpq is keg-only, put it in PATH
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"

# aws autocompletion
complete -C "$(brew --prefix)/bin/aws_completer" aws

export GPG_TTY=$(tty)

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
eval "$(fzf --zsh)"

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# bat as man pager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# completions
source <(kubectl completion zsh)
source <(helm completion zsh)
source <(gh completion -s zsh)

# mise (language version manager)
eval "$(mise activate zsh)"

# aliases
alias k="kubectl"
alias tf="terraform"
alias cat="bat --pager=never"
