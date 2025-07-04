system_name=`uname -s`

. ~/.aliases/colours
. ~/.ps1_color

#git_piece='$(__git_ps1 " \[$color_red\]%s\[$color_none\]")'
date_piece="\[${color_gray}\]\$(date '+%a %H:%M:%S')\[${color_none}\]"
export PS1="${date_piece} \u\[${color_ps1}\]@\[${color_none}\]\h \[${color_gray}\]\w\[${git_piece}\]\n\[${color_ps1}\]\$\[${color_none}\] "
umask 022

if [ $system_name == 'Linux' ]; then
  [ -f /etc/bash_completion ] && . /etc/bash_completion

  export EDITOR='vim'
else
  [ -f /opt/local/etc/bash_completion ] && . /opt/local/etc/bash_completion

  export EDITOR='mate -w'
fi

export ARCHFLAGS='-arch i386'
export MAKEFLAGS='-j4'
export RUBYLIB="lib:test:$RUBYLIB"
export GEMS="`gem env gemdir`/gems"
export HISTSIZE=1000000

bind "set show-all-if-ambiguous On"

#shopt -s globstar

# coloured ls
if [ "$TERM" != "dumb" ]; then
  if [ $system_name == 'Linux' ]; then
    color_option='--color=auto'

    alias du='du -k --max-depth=1'
  else
    color_option='-G'

    alias du='du -k -d1'
    alias top='top -o cpu'

    alias vi='mate'
  fi

  alias ls="ls $color_option"
  alias ll="ls -lh $color_option"
  alias la="ls -a $color_option"
  alias lal="ls -lha $color_option"

  . ~/.scripts/j.sh

else
  # TODO use path_helper to do this properly
  export PATH=/opt/local/bin:$PATH
fi

alias df='df -h'
alias less='less -R'

. ~/.aliases/git
. ~/.aliases/commands

export PATH="$HOME/.yarn/bin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/glen/src/work/bitgenics/linc-cd/github-pr-ui/node_modules/tabtab/.completions/serverless.bash ] && . /Users/glen/src/work/bitgenics/linc-cd/github-pr-ui/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/glen/src/work/bitgenics/linc-cd/github-pr-ui/node_modules/tabtab/.completions/sls.bash ] && . /Users/glen/src/work/bitgenics/linc-cd/github-pr-ui/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/glen/src/work/bitgenics/linc-cd/cd/node_modules/tabtab/.completions/slss.bash ] && . /Users/glen/src/work/bitgenics/linc-cd/cd/node_modules/tabtab/.completions/slss.bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source "$HOME/.cargo/env"
