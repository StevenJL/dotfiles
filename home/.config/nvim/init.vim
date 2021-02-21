" map kj to ESC
imap kj <ESC>

" Show line numbers in editor
set number

" Shows file name in terminal window title bar
set title

" When line length exceeds editor width, content does not wrap around
set nowrap

" Uses indents to fold code (https://en.wikipedia.org/wiki/Code_folding)
" Press space to unfold lines
" Press A-Z to fold lines
set foldmethod=indent
" When opening a new file, only highly indented lines get folded
set foldlevel=20

" When text is selected in visual mode, pressing cc puts content in clipboard
vmap cc !pbcopy <CR>u

" The Vim statusline shows up in lower left, to the right next to the filename
" These lines customize the status line to show useful information. See: https://shapeshed.com/vim-statuslines/
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%f
set statusline+=\ %m
set statusline+=col:\ %c"

"Short-cuts for toggling between vim split screens
" Press :vs to vertically split into two screens
" Control-L will move cursor to the right screen
nnoremap <C-l> <C-w>l
" Control-H will move cursor back to the left screen
nnoremap <C-h> <C-w>h
" Press :split to horizontally split into two screens
" Control-J will move cursor to bottom screen
nnoremap <C-j> <C-w>j
" Control-K will move cursor to top screen
nnoremap <C-k> <C-w>k

" Short-cuts for opening/navigating vim tabs
" Control-M opens a new vim tab
nmap <silent> <c-m> :tabnew<CR>
" Control-A navigates to left tab
nmap <silent> <c-a> :tabp<CR>
" Control-S navigates to right tab
nmap <silent> <c-s> :tabn<CR>

" I prefer using the comma key (,) as my leader key
" What is a leader key? See: https://learnvimscriptthehardway.stevelosh.com/chapters/06.html
let mapleader = ","
" Henceforth, every <leader> reference in this file will refer to the comma key (,)

"Copy the current file path to the clipboard
" Pressing <leader>cp copies
nnoremap <leader>cp :!echo -n % \| pbcopy<CR><CR>

" PLUGINS
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-fugitive'
  Plug 'flazz/vim-colorschemes'
  Plug 'neoclide/coc.nvim'
call plug#end()

" NerdTree customization
" Map Control-N to open nerdtree
nmap <silent> <c-n> :NERDTreeToggle<CR>
" Show hidden files in nerdtree
let NERDTreeShowHidden=1
" Pressing <leader> + N shows the current file inside Nerdtree
nnoremap <leader>n :NERDTreeFind<cr>

" CtrlP Customization
let g:ctrlp_regexp = 1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

" fzf customization
" map Control-F to fzf-ripgrep
nmap <silent> <c-f> :Rg<CR>

"" COC
nmap <silent> gd <Plug>(coc-definition)
let g:coc_node_path = '/Users/developer/.nvm/versions/node/v10.12.0/bin/node'

"Ale customization
let g:ale_linters = { 'ruby': ['rubocop', 'ruby', 'standardrb'], 'javascriptreact': ['javascript', 'jsx'] }

" Fugitive
nnoremap <leader>gb :Git blame<cr>

" Colorscheme
colorscheme leo

