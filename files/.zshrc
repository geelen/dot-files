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
export PATH="$HOME/.opencode/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Use Python 3.12 for gcloud (3.13+ causes hangs on import)
export CLOUDSDK_PYTHON=/opt/homebrew/opt/python@3.12/bin/python3.12

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

eval "$(tree-me shellenv 2>/dev/null)"

# mise (ruby/node/python version manager)
eval "$(mise activate zsh)"

# Connect to computelab with iTerm2 tmux integration
# Creates or reattaches to a persistent tmux session named "main"
computelab() {
    ssh computelab-sc-01 -t "tmux -u -CC new-session -A -s main"
}

# Connect to devvm with iTerm2 tmux integration
# Reattaches to "main" when present, otherwise creates it.
devvm() {
    ssh devvm-gmaddern -t "tmux -u -CC attach-session -t main || tmux -u -CC new-session -s main"
}

# opencode
export PATH=/Users/gmaddern/.opencode/bin:$PATH

# peon-ping quick controls
alias peon="bash /Users/gmaddern/.claude/hooks/peon-ping/peon.sh"
[ -f /Users/gmaddern/.claude/hooks/peon-ping/completions.bash ] && source /Users/gmaddern/.claude/hooks/peon-ping/completions.bash

# GitHub token for tools that call GitHub API (e.g. mise github: backends)
export GITHUB_TOKEN="$(gh auth token 2>/dev/null || true)"
