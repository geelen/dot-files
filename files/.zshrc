. ~/.zsh/rc

export PATH="$HOME/.yarn/bin:$PATH"

# Wasmer
export WASMER_DIR="/home/glen/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
