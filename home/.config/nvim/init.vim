" map kj to ESC
imap kj <ESC>

" Show line numbers in editor
set number

" Shows full file name in terminal window title bar
set title
set titlestring=%{expand('%:p')}

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

"Show the current file path 
" Pressing <leader>p show current file path
nnoremap <leader>p :<C-u>echo expand('%:.:r')<CR>

"Copy the current file path to the clipboard
" Pressing <leader>cp copies current file path into clipboard
nnoremap <leader>cp :call system('pbcopy', expand('%:.'))<CR><CR>

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
  Plug 'hashivim/vim-terraform'
  Plug 'prisma/vim-prisma'
  Plug 'kchmck/vim-coffee-script'
  Plug 'itchyny/lightline.vim'
  Plug 'hrsh7th/nvim-cmp' " Core completion engine'
  Plug 'hrsh7th/cmp-nvim-lsp'     " LSP completion
  Plug 'hrsh7th/cmp-buffer'       " Buffer completion
  Plug 'hrsh7th/cmp-path'         " Path completion
  Plug 'hrsh7th/cmp-cmdline'      " Command line completion
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'neovim/nvim-lspconfig'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'greggh/claude-code.nvim'
call plug#end()
" Run :PlugInstall once to install all these plugins

" ##################### Claude AI
" First run npm install -g @anthropic-ai/claude-code to install the Claude
" Coding Agent
luafile ~/.config/nvim/lua/claude-setup.lua

" ################### neoclide/coc.nvim #########################
" For neoclide/coc.nvim
" Run this vim command after install
" `:CocInstall coc-tsserver`

set nobackup
set nowritebackup
" Disable Vim's automatic backup file creation.
" Some language servers can get confused by backup files
" Modern development relies on version control (Git) for backup, not Vim's backup system
set cmdheight=2
" Makes the command line area 2 lines tall instead of the default 1 line.
" Helps with COC messages
set updatetime=300
" Makes COC feel less sluggish

" Always show the signcolumn
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

"" suggestions and auto-complete
" suggestions automatically pop-up, use Ctrl-N and Ctrl-P to scroll
" use tab to select
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() : "\<TAB>"
" ##################################################################

"c-ctags
" If using c-tags in vim, to jump to definition, just do Ctrl-]

" ################# TypeScript LSP setup ###################################

" First install the typescript language server
"   `npm install -g typescript typescript-language-server`
"
" Then check that Plug 'neovim/nvim-lspconfig' is installed in the Plug
" section
lua << EOF
  require'lspconfig'.tsserver.setup{}
EOF

" ############ Go-to Definition and Finding References #####################################
" Note this go-to-defintion is powered by the neovim/nvim-lspconfig plug-in!

" In normal mode, when cursor is on top of variable, type K to see type
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>

" With the LSP installed, you can also just do Ctrl-] to go-to the definition
" For Ruby, install ripper-tags first:
" `gem install ripper-tags`
" `ripper-tags -R --exclude=vendor`

" In normal mode, when cursor is on top of something, type F to see all
" references
nnoremap <silent>F :lua vim.lsp.buf.references()<CR>

" Once the results are in the 'Quick Fix' window, highlight it with
" cursor and type Ctrl-T to open result in new tab
augroup QuickfixMappings
  autocmd!
  autocmd FileType qf nnoremap <buffer> <C-t> <cmd>tab split<CR><CR>
augroup END
" Or do Ctrl-V to open in vertical split
augroup QuickfixMappings
  autocmd!
  autocmd FileType qf nnoremap <buffer> <C-v> <C-w><CR><C-w>L
augroup END
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
"   `gem install rubocop` (if it's not already in project Gemfile)
"
" For python to work, will need to first install pylint:
"   pip3 install pylint
" For Coffeescript to work, first install coffeelint:
"   npm install -g coffeelint
" For SQL linter to work, first install sqlfluff:
"   pip3 install sqlfluff
" For Terraform linter to work, first install tflint:
"   brew install tflint
" Also ensure that terraform has been installed:
"   terraform version
let g:ale_linters = { 
			\'ruby': ['rubocop'], 
			\'javascriptreact': ['eslint', 'standard', 'tslint'],
			\'python': ['bandit', 'flake8', 'jedils', 'mypy', 'prospector', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylama', 'pylint', 'pyls', 'pyre', 'pyright', 'vulture'],
      \'coffescript': ['coffeelint'],
      \'sql': ['sqlint'],
      \'terraform': ['tflint', 'terraformvalidate'],
			\}

" Fugitive
nnoremap <leader>gb :Git blame<cr>

" Colorscheme
colorscheme leo

"number of lines for syntax synchronization
set synmaxcol=5000
syntax sync minlines=2000

"Show git history for current file
noremap <leader>gh :GV!<CR>
nnoremap <leader>gc :GV<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



" Generate random 8-digit hex at cursor, used in WX-System
function! GenerateRandomEightDigitHex()
  " Set length to 8
  let l:length = 8
  
  " Define alphabet
  let l:alphabet = '0123456789abcdef'
  let l:alphabet_length = strlen(l:alphabet)
  
  " Set random seed
  let l:seed = localtime() % 0x10000
  let l:random = l:seed
  
  " Initialize empty result
  let l:result = '#'
  
  " Generate each character of the result
  let l:i = 0
  while l:i < l:length
    " Generate next random value (linear congruential generator)
    let l:random = (l:random * 214013 + 2531011) % 0x10000
    let l:rnd = (l:random / 256) % l:alphabet_length
    
    " Append random character from alphabet
    let l:result.= l:alphabet[l:rnd]
    
    let l:i += 1
  endwhile
  let l:result.= ' '
  
  return l:result
endfunction

function! PromiseThenCatchIdiom()
  return ".then(() => {\n})\n.catch((err: Error) => {\n  const error: Error = new Error(\n  );\n  logger.error(error);  throw error;\n});"
endfunction

nnoremap <leader>rd "=GenerateRandomEightDigitHex()<CR>p
noremap <leader>tc "=PromiseThenCatchIdiom()"<CR>p

