set nocompatible

set ruler
set laststatus=2

syntax enable
colorscheme solarized

set expandtab
set sw=4
set tabstop=4
set smarttab

set hlsearch
set incsearch
set smartcase
set ignorecase

set autoindent

set relativenumber

set textwidth=80
set colorcolumn=+1
set cursorline

:highlight ExtraWhitespace ctermbg=7
:match ExtraWhitespace /\s\+$/

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
  set directory=./.vim-swap//
  set directory+=~/.vim/swap//
  set directory+=~/tmp//
  set directory+=.
