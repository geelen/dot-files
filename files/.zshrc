autoload colors; colors;
setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}%B["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

function git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git_current_branch)
  [[ -z $ref ]] && return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function parse_git_dirty () {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

function prompt_char() {
}
#
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:git*:*' get-revision true
#zstyle ':vcs_info:git*:*' check-for-changes true
#
## hash changes branch misc
#zstyle ':vcs_info:git*' formats "(%s) %12.12i %c%u %b%m"
#zstyle ':vcs_info:git*' actionformats "(%s|%a) %12.12i %c%u %b%m"

PROMPT='%{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) $(prompt_char)'

function rvm_prompt_info() {
  ruby_version=$(~/.rvm/bin/rvm-prompt 2> /dev/null) || return
  echo "$ruby_version"
}

RPROMPT='%{$fg[yellow]%}$(rvm_prompt_info)%{$reset_color%}'

# Completion.

autoload -U compinit
compinit -i

# History.
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# Customize to your needs...
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export EDITOR='mate -w'

export CLICOLOR=1                                         # Make ls colour its output.
export LESS=-R                                            # Make less support ANSI colour sequences.
export RUBYOPT=rubygems                                   # Make Ruby load rubygems without a require.
export ACK_OPTIONS="--nosql --type-set cucumber=.feature" # Make ack ignore sql dumps, and search cucumber features.

. ~/.aliases/git
. ~/.aliases/env
. ~/.aliases/commands

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
