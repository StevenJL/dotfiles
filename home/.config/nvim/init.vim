" map kj to ESC
imap kj <ESC>

" Show line numbers in editor
set number

" Shows file name in terminal window title bar
set title

" When line length exceeds editor width, content does not wrap around
set nowrap

" Use spaces for tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"Fast commenting/uncommenting of code blocks
vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

" Uses indents to fold code (https://en.wikipedia.org/wiki/Code_folding)
" Press space to unfold lines
" Press A-Z to fold lines
set foldmethod=indent
" When opening a new file, only highly indented lines get folded
set foldlevel=20

"copying to clipboard on Mac OS X
" When text is selected in visual mode, pressing cc puts content in clipboard
vmap cc "*y

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

" :PlugInstall to install plug-ins
" :PlugStatus to see which plug-ins installed
call plug#begin('/Users/stevenli/.config/nvim/autoload')
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'wookayin/fzf-ripgrep.vim'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-fugitive'
  Plug 'flazz/vim-colorschemes'
  Plug 'junegunn/gv.vim'
  Plug 'ngmy/vim-rubocop'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'prisma/vim-prisma'
  Plug 'kchmck/vim-coffee-script'
  Plug 'itchyny/lightline.vim'
  Plug 'liuchengxu/vista.vim'
call plug#end()
" Run :PlugInstall once to install all these plugins

" For the Vim-COC plugin, this makes `tab` select the selected auto-fill suggestion
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#_select_confirm() : "\<Tab>"

" For the Vim-vista Plugin to use ctags when opening sidebar
let g:vista_default_executive = 'ctags'
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" For the Vim-vista Plugin, automatically show the nearest
" method/function in Vista side panel
set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Tell vim-vista to use ctags for typescriptreact
let g:vista_ctags_source = {
      \ 'typescriptreact': 'ctags',
      \ }

" Make Vim-vista play nicely with lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \    'filename': '%F',
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }

"c-ctags
" If using c-tags in vim, to jump to definition, just do Ctrl-]

" ####################### TypeScript LSP setup #################################################
" First install the typescript language server
"   `npm install -g typescript typescript-language-server`
"
" Then check that Plug 'neovim/nvim-lspconfig' is installed in the Plug
" section
lua << EOF
  require'lspconfig'.tsserver.setup{}
EOF

" In normal mode, when cursor is on top of variable, type K to see type
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>

" With the LSP installed, you can also just do Ctrl-] to go-to the definition
" ######################################################################



" Rubocop auto correct
let g:vimrubocop_keymap = 0
nmap <Leader>ra :RuboCop -a<CR>

" NerdTree customization
" Map Control-N to open nerdtree
nmap <silent> <c-n> :NERDTreeToggle<CR>
" Show hidden files in nerdtree
let NERDTreeShowHidden=1
" Pressing <leader> + N shows the current file inside Nerdtree
nnoremap <leader>n :NERDTreeFind<cr>

"Ctrl-F and Ctrl-P are provided by the junegunn/fzf.vim plug-ins
" fzf customization
" will need to install first: 
"   brew install fzf
"   brew install ripgrep
" map Control-F to fzf-ripgrep
nmap <silent> <c-f> :RgFzf<CR>
"map Control-P to file search
nmap <silent> <c-p> :GFiles<CR>

"Ale customization
" See this: https://github.com/dense-analysis/ale/blob/master/doc/ale.txt#L1438
" :ALEInfo to see which linters are currently being used
" For Ruby to work, need to install rubocop first
"   gem install rubocop (if it's not already in project Gemfile)
" For python to work, will need to first install pylint:
"   pip3 install pylint
" For Coffeescript to work, first install coffeelint:
"   npm install -g coffeelint
let g:ale_linters = { 
			\'ruby': ['rubocop'], 
			\'javascriptreact': ['eslint', 'standard', 'tslint'],
			\'python': ['bandit', 'flake8', 'jedils', 'mypy', 'prospector', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylama', 'pylint', 'pyls', 'pyre', 'pyright', 'vulture'],
      \'coffescript': ['coffeelint']
			\}

" Fugitive
nnoremap <leader>gb :Git blame<cr>

" Colorscheme
colorscheme leo

"Show git history for current file
noremap <leader>gh :GV!<CR>
nnoremap <leader>gc :GV<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

