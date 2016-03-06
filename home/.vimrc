let mapleader = ","
let NERDTreeShowHidden=1
let g:ctrlp_max_files=0
if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*,*/public/*,*/node_modules/*
execute pathogen#infect()
syntax on
filetype plugin indent on
filetype on
set nocompatible
set number
set ruler
set tabstop=2
set expandtab
set nowrap
set shiftwidth=2
set foldlevel=1
set autoindent
set noswapfile
set splitbelow
set splitright
set t_Co=256
colorscheme leo
imap kj <ESC>
vmap cc !pbcopy <CR>u
nmap <silent> <c-n> :NERDTreeToggle<CR>
set runtimepath^=~/.vim/bundle/ctrlp.vim
set pastetoggle=<F2>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

