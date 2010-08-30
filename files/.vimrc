syntax on
set expandtab
set ts=2 sw=2 sws=2
set autoindent nosmartindent nocindent

filetype plugin on
filetype indent off

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set backup " keep backup file after overwriting a file
set backupdir=~/.vim_backups " directory for the backups

:map <C-a> ^
:map <C-e> $
:cmap <C-a> <home>
:cmap <C-e> <end>
:imap <C-e> <ESC>$i<right>
:imap <C-a> <ESC>^i
