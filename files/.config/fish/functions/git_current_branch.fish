function git_parse_branch
  sh -c 'git symbolic-ref HEAD 2> /dev/null' | sed -e 's/refs\/heads\///'
end
