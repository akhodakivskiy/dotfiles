set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-grepper'

call plug#end()

filetype plugin indent on    " required

" ======================================

" Tailing space
match ErrorMsg '\s\+$'
command! TrimWhiteSpace %s/\s\+$//e

" Search
set incsearch
set ignorecase
set smartcase

" Indentation
set cindent
set smartindent
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Leader, mouse, undo-redo, swap
let mapleader=","
set mouse=a
set number
set undofile
set undodir=~/.vim/undo
set directory=~/.vim/swap

" fzf
nnoremap <leader>c :Files<CR>
nnoremap <leader>g :Grepper<CR>
nnoremap \ :NERDTreeToggle<CR>

set clipboard=unnamedplus
