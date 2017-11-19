call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'tomasr/molokai'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'suan/vim-instant-markdown'
Plug 'bronson/vim-trailing-whitespace'

call plug#end()

syntax on
filetype plugin indent on
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set encoding=utf-8
set scrolloff=0
set autoindent
set showmode
set showcmd
set autoread
set hidden
set backspace=indent,eol,start
set laststatus=2
set number
set ignorecase
set smartcase
set hlsearch
set cursorline
set colorcolumn=80
set mouse=a

" Arrow keys
noremap <Down> gj
noremap <Up> gk

" Remap movement to move by column layout
nnoremap j gj
nnoremap k gk

" Window splitting remap"
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j

" Strips whitespace
nnoremap <leader>W :FixWhitespace<CR>

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1

" NERD Tree settings
" Have NERD Tree open when no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Vim close if onle NERD tree opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Relative number toggle
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" Theme
let g:onedark_terminal_italics = 1
let g:onedark_termcolors = 256
if (has("termguicolors"))
  set termguicolors
endif
colorscheme molokai

" NERD Tree mappings
nnoremap <leader>d :NERDTreeToggle<CR> :winc =<CR>
nnoremap <leader>f :NERDTreeFocus<CR> :winc =<CR>

" Delete buffer without closing the window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <PageUp> :bp<Enter>
nnoremap <PageDown> :bn<Enter>

" Space between comment and delimiters
let g:NERDSpaceDelims = 1

" Use clang-format
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
