call plug#begin()

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-grepper'

call plug#end() " also runs: filetype plugin indent on, syntax enable

" ======================================

" Tailing space
match ErrorMsg '\s\+$'
command! TrimWhiteSpace %s/\s\+$//e

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
" Esc Esc clears search highlight
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" Indentation
set autoindent
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

" System clipboard for yank/paste: * on macOS, + on Linux (needs +clipboard)
if has('clipboard')
  set clipboard^=unnamed,unnamedplus
endif
