let mapleader = ","
let NERDTreeShowHidden=1
let g:ctrlp_max_files=0
let g:ruby_fold_lines_limit=200
let g:ackprg = 'ag --nogroup --nocolor --column'
set backspace=indent,eol,start
if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*,*/node_modules/*
set runtimepath+=~/.vim/bundle/swift.vim
execute pathogen#infect()
syntax on
filetype plugin indent on
filetype on
set title
set nocompatible
set number
set ruler
set tabstop=2
set expandtab
set nowrap
set hls
set shiftwidth=2
set foldlevel=1
set autoindent
set noswapfile
set splitbelow
set splitright
set t_Co=256
set foldmethod=syntax
colorscheme leo
imap kj <ESC>
vmap cc !pbcopy <CR>u
nmap <silent> <c-n> :NERDTreeToggle<CR>
nmap <silent> <c-a> :tabp<CR>
nmap <silent> <c-s> :tabn<CR>
nmap <silent> <c-m> :tabnew<CR>
set runtimepath^=~/.vim/bundle/ctrlp.vim
set pastetoggle=<F2>

set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%f
set statusline+=\ %m
set statusline+=col:\ %c

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <leader>cp :let @+=expand("%:p")<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>n :NERDTreeFind<cr>

vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

function! RubyMethodFold(line)
  let line_is_method_or_end = synIDattr(synID(a:line,1,0), 'name') == 'rubyMethodBlock'
  let line_is_def = getline(a:line) =~ '\s*def '
  let line_is_context = getline(a:line) =~ '\s*context '
  let line_is_describe = getline(a:line) =~ '\s*describe '
  return line_is_method_or_end || line_is_def || line_is_context || line_is_describe
endfunction

set foldexpr=RubyMethodFold(v:lnum)

autocmd BufWritePre * :%s/\s\+$//e

