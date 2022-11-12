# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DEFAULT_USER=$(whoami)

# load antigen
source /usr/local/share/antigen/antigen.zsh
# load theme
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# configuring completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  plugins=(… zsh-completions)
  autoload -U compinit && compinit -i
fi

# enable azure-cli completion
autoload -U +X bashcompinit && bashcompinit
source /usr/local/etc/bash_completion.d/az

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# libpq is keg-only, put it in PATH:
export PATH="/usr/local/opt/libpq/bin:$PATH"

# aws-autocompletion
export PATH="/usr/local/bin/aws_completer:$PATH"
