# zmodload zsh/zprof

typeset -g POWERLEVEL9K_DISABLE_SSH_CONTEXT=true

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. ~/.zsh/rc

export PATH="$HOME/.yarn/bin:$PATH"

# Wasmer
export WASMER_DIR="/home/glen/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# zprof

# opencode
export PATH=/Users/glenmaddern/.opencode/bin:$PATH

# bun completions
[ -s "/Users/glenmaddern/.bun/_bun" ] && source "/Users/glenmaddern/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
