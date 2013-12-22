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
