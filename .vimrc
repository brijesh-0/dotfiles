let mapleader = " "

" === BEHAVIOR ===
set nocompatible
set backspace=indent,eol,start
set encoding=utf-8
set hidden
set autoread

" No swap/backup files cluttering remote dirs
set noswapfile
set nobackup
set nowritebackup

" Persistent undo (survives session)
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo
  silent !mkdir -p ~/.vim/undo
endif

" === VISUAL ORIENTATION ===
set number
" set cursorline
set laststatus=2
set ruler
set showcmd
set showmode
set scrolloff=5
set sidescrolloff=5
set wrap
set linebreak

" === SEARCH ===
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <C-n> :nohlsearch<CR>

" === INDENTATION ===
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" === WHITESPACE VISIBILITY ===
set list
set listchars=tab:▸\ ,trail:·,nbsp:␣

" === PERFORMANCE / SSH ===
set lazyredraw
set ttyfast
set timeoutlen=500
set ttimeoutlen=10
set noerrorbells
set novisualbell

" === SPLITS ===
set splitbelow
set splitright

" === STATUSLINE ===
set statusline=%f\ %m%r%h%w\ [%Y]\ [%{&ff}]%=%l/%L\ col:%c\ %p%%

" === NAVIGATION ===
nnoremap j gj
nnoremap k gk
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
vnoremap < <gv
vnoremap > >gv
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

" === APPEARANCE ===
set t_Co=256
filetype plugin indent on
syntax on

" Change cursor shape based on mode
let &t_SI = "\e[5 q" " SI = Insert mode (5 = vertical line)
let &t_SR = "\e[3 q" " SR = Replace mode (3 = underline)
let &t_EI = "\e[2 q" " EI = Normal mode / End Insert (2 = solid block)

highlight LineNr ctermfg=244 guifg=#808080
