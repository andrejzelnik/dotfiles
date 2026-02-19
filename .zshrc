# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DEFAULT_USER=$(whoami)

# load antigen
source $(brew --prefix)/share/antigen/antigen.zsh
# load theme
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# configuring completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  plugins=(… zsh-completions)
  autoload -U compinit && compinit -i
fi

# enable azure-cli completion
autoload -U +X bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# libpq is keg-only, put it in PATH:
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"

# aws-autocompletion
complete -C "$(brew --prefix)/bin/aws_completer" aws

export GPG_TTY=$(tty)
