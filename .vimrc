call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Yggdroot/indentLine'
Plug 'babaybus/DoxygenToolkit.vim'
Plug 'drmikehenry/vim-headerguard'
Plug 'AndrewRadev/linediff.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'jose-elias-alvarez/null-ls.nvim'

if has('nvim')
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
endif

" Install fzf in .fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

syntax on
filetype plugin indent on
set number
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set encoding=utf-8
set scrolloff=3
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
set colorcolumn=100
set mouse=a
set guicursor=
" Allow reccursive search on path
set path+=**
" Align on open parentheresis for indentation of multi-line statements
" set cinoptions=(0
set completeopt=longest,menuone
set listchars=tab:→\ ,trail:·

let mapleader = " "

" Diff mappings put/get then move to next change
nnoremap <leader>dg :diffget<CR>]c
nnoremap <leader>dp :diffput<CR>]c

" Disable visual mode
nnoremap Q <Nop>

" Disable highlight
nnoremap <leader><Space> :noh<CR>

" Arrow keys
noremap <Down> gj
noremap <Up> gk

" Remap movement to move by column layout
nnoremap j gj
nnoremap k gk

nnoremap ; :
vnoremap ; :

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

let g:indentLine_char = '┊'

" // comments for C
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

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
colorscheme gruvbox
set background=dark
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = 'hard'
" Transarency
hi Normal guibg=NONE ctermbg=NONE

" NERD Tree mappings
nnoremap <leader>d :NERDTreeToggle<CR> :winc =<CR>

" Delete buffer without closing the window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <PageUp> :bp<Enter>
nnoremap <PageDown> :bn<Enter>

" Quick access to vimrc
nnoremap <F12> :e ~/.vimrc<CR>

" Space between comment and delimiters
let g:NERDSpaceDelims = 1

" Use clang-format
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Tag generation
command! MakeTags !ctags -R -n --fields=+i+K+S+l+m+a --extra=+q --c++-kinds=+p+l --exclude="*.S" --exclude=aps.c --exclude=nwk.c --exclude="*python/*"
nnoremap <F4> :MakeTags<CR>

" Refresh buffers
nnoremap <F5> :checktime<CR>

" Tagbar
nnoremap <F6> :Tagbar<CR>

" Gitlab plugin for fugitive
let g:fugitive_gitlab_domains = ['https://gitlab.corp.netatmo.com']

" fzf settings
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>h :Files ~<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>e :Rg <C-R><C-W><CR>
nnoremap <leader>r :Rg <CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 '-g'
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

" Git gutter
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hv <Plug>(GitGutterPreviewHunk)

" Fugitive
nmap <leader>gw :Gwrite<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gc :Git commit -v<CR>
nmap <leader>gC :Git commit -v --amend<CR>
nmap <leader>gs :Git<CR>
nmap <leader>gd :Gdiff<CR>

nmap <leader>p <Plug>MarkdownPreviewToggle

function! g:HeaderguardName()
  return join(["__", toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g')), "__"], "")
endfunction

lua require("lsp-config");

if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif
