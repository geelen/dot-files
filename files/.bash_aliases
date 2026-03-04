# ~/.bash_aliases — edit freely, then run 'reload' to apply
# ──────────────────────────────────────────────────────────

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Listing ---
alias ls='ls --color=auto'
alias ll='ls -alFh --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# --- Safety nets (bypass with \rm, \cp, \mv) ---
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

# --- Search ---
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# --- Disk & system ---
alias df='df -h'
alias du='du -h'
alias free='free -h'

# --- Git ---
alias gs='git status'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'

# --- Misc ---
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias reload='source ~/.bashrc'
alias cls='clear'
alias mkdir='mkdir -pv'
