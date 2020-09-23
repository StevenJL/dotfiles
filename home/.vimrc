let mapleader = ","
let NERDTreeShowHidden=1
let g:ruby_fold_lines_limit=200
let g:ackprg = 'ag --nogroup --nocolor --column'
set backspace=indent,eol,start
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

function! s:sort_by_header(bang, pat) range
  let pat = a:pat
  let opts = ""
  if pat =~ '^\s*[nfxbo]\s'
    let opts = matchstr(pat, '^\s*\zs[nfxbo]')
    let pat = matchstr(pat, '^\s*[nfxbo]\s*\zs.*')
  endif
  let pat = substitute(pat, '^\s*', '', '')
  let pat = substitute(pat, '\s*$', '', '')
  let sep = '/'
  if len(pat) > 0 && pat[0] == matchstr(pat, '.$') && pat[0] =~ '\W'
    let [sep, pat] = [pat[0], pat[1:-2]]
  endif
  if pat == ''
    let pat = @/
  endif

  let ranges = []
  execute a:firstline . ',' . a:lastline . 'g' . sep . pat . sep . 'call add(ranges, line("."))'

  let converters = {
        \ 'n': {s-> str2nr(matchstr(s, '-\?\d\+.*'))},
        \ 'x': {s-> str2nr(matchstr(s, '-\?\%(0[xX]\)\?\x\+.*'), 16)},
        \ 'o': {s-> str2nr(matchstr(s, '-\?\%(0\)\?\x\+.*'), 8)},
        \ 'b': {s-> str2nr(matchstr(s, '-\?\%(0[bB]\)\?\x\+.*'), 2)},
        \ 'f': {s-> str2float(matchstr(s, '-\?\d\+.*'))},
        \ }
  let arr = []
  for i in range(len(ranges))
    let end = max([get(ranges, i+1, a:lastline+1) - 1, ranges[i]])
    let line = getline(ranges[i])
    let d = {}
    let d.key = call(get(converters, opts, {s->s}), [strpart(line, match(line, pat))])
    let d.group = getline(ranges[i], end)
    call add(arr, d)
  endfor
  call sort(arr, {a,b -> a.key == b.key ? 0 : (a.key < b.key ? -1 : 1)})
  if a:bang
    call reverse(arr)
  endif
  let lines = []
  call map(arr, 'extend(lines, v:val.group)')
  let start = max([a:firstline, get(ranges, 0, 0)])
  call setline(start, lines)
  call setpos("'[", start)
  call setpos("']", start+len(lines)-1)
endfunction
command! -range=% -bang -nargs=+ SortGroup <line1>,<line2>call <SID>sort_by_header(<bang>0, <q-args>)

set foldexpr=RubyMethodFold(v:lnum)

autocmd BufWritePre * :%s/\s\+$//e

set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :GFiles<CR>
command! -bang -nargs=* FindWithRipGrep
  \ call fzf#vim#grep(
  \   'rg  --column --line-number --no-heading --fixed-strings --ignore-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <C-f> :FindWithRipGrep<CR>
