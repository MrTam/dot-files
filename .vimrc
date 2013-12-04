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
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'tomasr/molokai'

set rtp+=/opt/powerline/powerline/bindings/vim

filetype plugin indent on

set nocursorcolumn 
set nocursorline

set nocompatible

set autoread

set number

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
set vb t_vb=
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

colorscheme elflord 

" YCM Options

let g:ycm_confirm_extra_conf = 0

" Syntastic 

let g:syntastic_always_populate_loc_list = 1
let g:lt_location_list_toggle_map = '<F4>'

" Makeshift
nnoremap <F5> :<C-U>make<CR>

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
