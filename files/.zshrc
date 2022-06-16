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


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/glen/code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/glen/code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/glen/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/glen/code/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/Users/glen/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end