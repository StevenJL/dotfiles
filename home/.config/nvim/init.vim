" map kj to ESC
imap kj <ESC>

" Show line numbers in editor
set number

" Shows file name in terminal window title bar
set title

" When line length exceeds editor width, content does not wrap around
set nowrap

"Fast commenting/uncommenting of code blocks
vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

" Uses indents to fold code (https://en.wikipedia.org/wiki/Code_folding)
" Press space to unfold lines
" Press A-Z to fold lines
set foldmethod=indent
" When opening a new file, only highly indented lines get folded
set foldlevel=20

" When text is selected in visual mode, pressing cc puts content in clipboard
vmap cc !pbcopy <CR>u

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
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'wookayin/fzf-ripgrep.vim'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-fugitive'
  Plug 'flazz/vim-colorschemes'
  Plug 'neoclide/coc.nvim'
  Plug 'liuchengxu/vista.vim'
call plug#end()

" NerdTree customization
" Map Control-N to open nerdtree
nmap <silent> <c-n> :NERDTreeToggle<CR>
" Show hidden files in nerdtree
let NERDTreeShowHidden=1
" Pressing <leader> + N shows the current file inside Nerdtree
nnoremap <leader>n :NERDTreeFind<cr>

" fzf customization
" map Control-F to fzf-ripgrep
nmap <silent> <c-f> :RgFzf<CR>
"map Control-P to file search
nmap <silent> <c-p> :Files<CR>

" COC
" :CocConfig to see the config
" :CheckHealth to see status of lang analysis
nmap <silent> gd <Plug>(coc-definition)
let g:coc_node_path = '/Users/stevenli/.nvm/versions/node/v10.12.0/bin/node'

"Ale customization
" See this: https://github.com/dense-analysis/ale/blob/master/doc/ale.txt#L1438
" :ALEInfo to see which linters are currently being used
" For python to work, will need to first install pylint:
"   pip3 install pylint
let g:ale_linters = { 
			\'ruby': ['rubocop', 'ruby', 'standardrb'], 
			\'javascriptreact': ['eslint', 'standard'],
			\'python': ['bandit', 'flake8', 'jedils', 'mypy', 'prospector', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylama', 'pylint', 'pyls', 'pyre', 'pyright', 'vulture']
			\}

" Fugitive
nnoremap <leader>gb :Git blame<cr>

" Colorscheme
colorscheme leo

"Vista
nnoremap <leader>v :Vista coc<cr>

