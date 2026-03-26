# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY
HISTORY_IGNORE="(export AWS_SECRET*|export AWS_ACCESS*|vault login*|export.*TOKEN*|export.*PASSWORD*)"

# Editor
export EDITOR=vim
export VISUAL=vim

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Ensure Homebrew completions are in fpath before compinit
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

# start Zim
source ${ZIM_HOME:-~/.zim}/init.zsh

# enable bash-style completions (terraform, azure-cli)
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C "$(brew --prefix)/bin/terraform" terraform
_az_cache=~/.cache/zsh/az_completion.zsh
if [[ ! -f $_az_cache ]] || [[ -n $(find $_az_cache -mtime +7 2>/dev/null) ]]; then
  mkdir -p ~/.cache/zsh && cat $(brew --prefix)/etc/bash_completion.d/az > $_az_cache
fi
source $_az_cache
unset _az_cache

# libpq is keg-only, put it in PATH
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"

# aws autocompletion
complete -C "$(brew --prefix)/bin/aws_completer" aws

export GPG_TTY=$(tty)

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
# use fd for fzf file search (respects .gitignore, faster than find)
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
eval "$(fzf --zsh)"

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# bat
export BAT_THEME="Dracula"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# completions (cached, refreshed weekly)
_load_completion() {
  local cache=~/.cache/zsh/${1}_completion.zsh
  if [[ ! -f $cache ]] || [[ -n $(find $cache -mtime +7 2>/dev/null) ]]; then
    mkdir -p ~/.cache/zsh && "${@}" > $cache
  fi
  source $cache
}
_load_completion kubectl completion zsh
_load_completion helm completion zsh
_load_completion gh completion -s zsh
# kubectx/kubens completions are in Homebrew's site-functions (auto-loaded)

# mise (language version manager)
eval "$(mise activate zsh)"

# Starship prompt
eval "$(starship init zsh)"

# aliases — kubectl
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kgd="kubectl get deployments"
alias kga="kubectl get all"
alias kl="kubectl logs -f"
alias kx="kubectx"
alias kns="kubens"

# aliases — terraform
alias tf="terraform"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfi="terraform init"

# aliases — docker
alias d="docker"
alias dc="docker compose"
alias dps="docker ps"
alias dlog="docker logs -f"

# aliases — general
alias cat="bat --pager=never"
