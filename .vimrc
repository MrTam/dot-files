filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/ListToggle'
Bundle 'johnsyweb/vim-makeshift'
Bundle 'plasticboy/vim-markdown.git'
Bundle 'kien/ctrlp.vim'
Bundle 'tomasr/molokai'
Bundle 'blinks/vim-antlr'

set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim

syntax enable
filetype plugin indent on

set nocursorcolumn 
set nocursorline

set nocompatible

set autoread

set nonumber

set ambiwidth=single
set encoding=utf-8
set fileencoding=utf-8

set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw

set magic
set showmatch

set nowrap
set ttyfast

set noerrorbells
set novisualbell
"set vb t_vb=
"set t_Co=256
"set t_ut=
set tm=500

set nobackup
set nowb
set noswapfile

set expandtab
set smarttab

set shiftwidth=4
set tabstop=4

set ai
set si

set background=dark
colorscheme elflord 

" YCM Options

let g:ycm_confirm_extra_conf = 0

" Syntastic 

let g:syntastic_auto_loc_list=1
let g:syntastic_always_populate_loc_list = 1
let g:lt_location_list_toggle_map = '<F4>'

let g:syntastic_enable_python_checker = 1
let g:syntastic_python_checkers = ['flake8']

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠ '

let g:syntastic_enable_highlighting = 1

map <F5> :SyntasticCheck<CR>
map <F6> :SyntasticToggleMode<CR>

" Makeshift

" NERD Tree

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Easy Motion
"
let g:EasyMotion_leader_key = '<Leader>'

" Statusline stuff

set laststatus=2
set nosmd
set noru

" Fix home/end key in all modes
map <esc>OH <home>
cmap <esc>OH <home>
imap <esc>OH <home>
map <esc>OF <end>
cmap <esc>OF <end>
imap <esc>OF <end>

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Terminal Timout on esc
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Nested Jinja2 highlighting

function! TextEnableCodeSnip(filetype,start,end) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ keepend
  \ containedin=ALL
  \ contains=@'.group
endfunction

au BufNewFile,BufRead */templates/* call TextEnableCodeSnip('jinja', '{{', '}}')
au BufNewFile,BufRead */templates/* call TextEnableCodeSnip('jinja', '{%', '%}')
au BufNewFile,BufRead */templates/* call TextEnableCodeSnip('jinja', '{#', '#}')

" PEP8 friendly goodness for python 

au FileType python set autoindent
au FileType python set smartindent
au FileType python set textwidth=79 " PEP-8 Friendly

" Enable mouse copy+paste
se mouse+=a
