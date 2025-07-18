# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh setup
export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$(tty)
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# Source modular configs
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/paths.zsh
source ~/.zsh/scheduling.zsh

# Source private environment variables (if file exists)
[[ -f ~/.zsh/env.private ]] && source ~/.zsh/env.private

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Homebrew - Initialize only if not already configured
if [ -z "$HOMEBREW_PREFIX" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Syntax highlighting and autosuggestions
# Source plugins using the Homebrew prefix to avoid extra 'brew' calls
if [ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Vi mode
set -o vi

# FZF
eval "$(fzf --zsh)" 

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
