set nocompatible
filetype off
set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'jacoborus/tender'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim'}
" Plugin 'tpope/vim-rails.git'
" Plugin 'ack.vim'
Plugin 'sjl/badwolf'
Plugin 'plasticboy/vim-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
"Plugin 'groenewege/vim-less'
Plugin 'editorconfig-vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
"Plugin 'kien/ctrlp.vim'
" vim-scripts repos
" Plugin 'L9'
" Plugin 'FuzzyFinder'
Plugin 'scrooloose/NERDTree'
Plugin 'scrooloose/NERDCommenter'
Plugin 'scrooloose/syntastic'
Plugin 'Tabular'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
"Plugin 'leafgarland/typescript-vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'ternjs/tern_for_vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'sheerun/vim-polyglot'
Plugin 'armasm'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'raimondi/delimitmate'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'majutsushi/tagbar'
"Plugin 'klen/python-mode'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
" non github repos
" Plugin 'git://git.wincent.com/command-t.git'
" ...
call vundle#end()            " required
filetype plugin indent on     " required!

"set guifont       = "Menlo:5"
"let g:colors_name = "badwolf"
"set background    = "dark"
syntax enable
set background=dark
colorscheme solarized

set modelines=0
set nu
set ruler

" remap arrow keys
noremap <Down> gj
noremap <Up> gk

" copy
vnoremap <C-c> "+y

" Command T settings
let g:CommandTInputDebounce = 200
let g:CommandTFileScanner = "watchman"
let g:CommandTWildIgnore = &wildignore . ",**/bower_components/*" . ",**/node_modules/*" . ",**/vendor/*"
let g:CommandTMaxHeight = 30
let g:CommandTMaxFiles = 500000

" CtrlP settings
"
let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']  " Windows

" Syntastic
let g:syntastic_javascript_checkers = ['']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Tender
if (has("termguicolors"))
    set termguicolors
endif

"Some tips from http://stevelosh.com/blog/2010/09/coming-home-to-vim/"

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
set hidden
set wildmenu
set wildmode=list:longest,full
set visualbell
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set number
"set relativenumber
set cursorline
set mouse=a

" windows conemu fix
inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>

let mapleader = "!"

"Folding
set foldenable    " disable folding
set foldlevelstart=0

" open and close folds
nnoremap <space> za
nnoremap <space>o zA

"let g:vim_markdown_folding_disabled=1

" search remap
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" clear search
nnoremap <leader><space> :nohlsearch<cr>

" highlight last inserted text
nnoremap vG `[v`]

" match the next brace
nnoremap <tab> %
vnoremap <tab> %
set wrap
set formatoptions=qrn1
set linebreak

" remap movement to move by column layout
nnoremap j gj
nnoremap k gk

"User customizations"

" Strips whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Select pasted text
nnoremap <leader>v V`]

"Window splitting remap"
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j

" Buffers
nnoremap <leader>T :enew<cr>
nnoremap gy :bnext<CR>
nnoremap gt :bprevious<cr>
nnoremap gd :bdelete<cr>
nnoremap <leader>bl :ls<CR>

" Theme stuff
nnoremap <leader>1 :colorscheme obsidian<cr>
nnoremap <leader>2 :colorscheme tomorrow-night-bright<cr>
nnoremap <leader>3 :colorscheme molokai<cr>
nnoremap <leader>4 :colorscheme badwolf<cr>

" badwolf settings
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 2
let g:badwolf_css_props_highlight = 1
let g:badwolf_html_link_underline = 1

" Airline settings
let g:airline#extensions#tabline#enabled =1
let g:airline_powerline_fonts=1
let g:airline_theme = 'badwolf'
nnoremap <leader>d :NERDTreeToggle<CR> :winc =<CR>
nnoremap <leader>f :NERDTreeFocus<CR> :winc =<CR>
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeIgnore = ['\.o$']

augroup file_types
    autocmd!
    autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.txt set filetype=markdown
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.view set filetype=php
    autocmd BufNewFile,BufRead *.less set filetype=less
    autocmd BufRead,BufNewFile *.js set ft=javascript syntax=javascript
    autocmd BufRead,BufNewFile *.ts set ft=typescript syntax=typescript
    autocmd BufRead,BufNewFile *.es6 set ft=javascript syntax=javascript
    autocmd BufRead,BufNewFile *.json set ft=json syntax=javascript
    autocmd BufRead,BufNewFile *.twig set ft=htmldjango
    autocmd BufRead,BufNewFile *.rabl set ft=ruby
    autocmd BufRead,BufNewFile *.jade set ft=jade
augroup END

" Whitespace fixes
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

augroup whitespace
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END

set undolevels=20
set title

set noerrorbells
set noswapfile
set nobackup
nnoremap ; :


" Tabular
nnoremap <leader>a= :Tabularize /=<CR>
vnoremap <leader>a= :Tabularize /=<CR>
nnoremap <leader>a: :Tabularize /:\zs<CR>
vnoremap <leader>a: :Tabularize /:\zs<CR>

" Custom maps
set pastetoggle=<leader>p
nnoremap <leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

nnoremap <leader>vi :vsplit $MYVIMRC<cr>
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
nnoremap <leader>re gg=G

" Save
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Abbreviations
iabbrev adn and
iabbrev waht what
"nnoremap H 00
"nnoremap L $
inoremap jk <esc>

" Arrow keys
"nnoremap <left> h
"nnoremap <right> l
"nnoremap <up> k
"nnoremap <down> j

"inoremap <left> h
"inoremap <right> l
"inoremap <up> k
"inoremap <down> j

set fileformat=unix
set fileformats=unix,dos

" Abbreviations
"augroup abbreviations
"autocmd!
"autocmd FileType html :iabbrev <buffer> --- &mdash;
"autocmd FileType javascript :iabbrev <buffer> ret return
"augroup END
"

"Arm asm
let asmsyntax='armasm'
let filetype_inc='armasm'


set colorcolumn=81

" Page up and down to switch buffers, delete buffer without closing window
nnoremap <PageUp> :bp<Enter>
nnoremap <PageDown> :bn<Enter>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <F12> :e ~/.vimrc<Enter>

"Git shortcuts
map <leader>gs <C-w>z:Gstatus<CR>6G
map <leader>gc :Gcommit -a<CR>
map <leader>gp :Gpush<CR>
map <leader>gl :!tig<CR>
map <leader>gg :GitGutterToggle<CR>
let g:gitgutter_enabled = 0

nnoremap <F5> :make run<Enter>
nnoremap <F6> :!scp exercice2b.* glagrange@telecom:~/public_html<Enter>
let g:pymode_run_bind = '<leader>r'
let g:pymode_python = 'python3'

" Deactivage hilghlights
nnoremap ù :noh<Enter>

" IndentGuides Options
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey
"let g:indent_guides_enable_on_vim_startup = 1

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:AutoPairsMapBS = 1
let g:spf13_no_omni_complete = 1

" Tagbar
map <leader>t ::TagbarToggle<CR>
