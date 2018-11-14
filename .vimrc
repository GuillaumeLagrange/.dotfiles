call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dracula/vim'
Plug 'embear/vim-localvimrc'
Plug 'tomasr/molokai'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'suan/vim-instant-markdown'
Plug 'bronson/vim-trailing-whitespace'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-unimpaired'
" Install fzf in .fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
call plug#end()

syntax on
filetype plugin indent on
set number
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set colorcolumn=100
set mouse=a
set guicursor=
" Allow reccursive search on path
" set path+=**
" Align on open parentheresis for indentation of multi-line statements
set cinoptions=(0

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

" NERD Tree settings
let NERDTreeMinimalUI=1
" Have NERD Tree open when no file specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
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
" if (has("termguicolors"))
  " set termguicolors
" endif
colorscheme molokai

" NERD Tree mappings
nnoremap <leader>d :NERDTreeToggle<CR> :winc =<CR>

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

" Deoplete
" let g:deoplete#enable_at_startup = 1
" " let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
" " let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'
" "tab completion
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" disable preview window
set completeopt-=preview
set completeopt=longest,menuone

" ALE
let g:ale_linters = {
            \   'c': ['clangtidy'],
            \}

" (optional, for completion performance) run linters only when I save files
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Tag generation
command! MakeTags !ctags -R -n --fields=+i+K+S+l+m+a --exclude=app.S
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
nnoremap <leader>f :Files<CR>
nnoremap <leader>h :Files ~<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Tags<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

" Git gutter
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" Fugitive
nmap <leader>gw :Gwrite<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gca :Gcommit -v --amend<CR>
nmap <leader>gc :Gcommit -v<CR>
nmap <leader>gs :Gstatus<CR>

command! -bang FLines call fzf#vim#grep(
     \ 'grep -vnITr --color=always --exclude-dir=".svn" --exclude-dir=".git" --exclude=tags --exclude=*\.pyc --exclude=*\.exe --exclude=*\.dll --exclude=*\.zip --exclude=*\.gz --exclude=*\.S --exclude=*\.map "^$"',
     \ 0,
     \ {'options': '--reverse --prompt "FLines> "'})
nnoremap <silent> <leader>e :FLines<cr>

