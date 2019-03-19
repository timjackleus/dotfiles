
"""""""""" General ViM Settings """"""""""
scriptencoding utf-8
filetype plugin indent on
syntax on " Use syntax highlighting

set encoding=utf-8  " Use utf-8 encoding
set nocompatible " Make Vim more useful
set ignorecase " " ignore upper/lower case when searching
set incsearch " show partial matches for a search phrase
set hlsearch " gnore case (for searching))
set nofoldenable " disable folding
set scrolloff=3 " Keep 3 lines (top/bottom) for scope
set number " Display line numbers on the left
set noswapfile " Disable swap files creation
set report=0 " tell us when anything is changed via :...
set omnifunc=syntaxcomplete#Complete " Use Autocomplete
set mouse=a " Scrollable term-vim
set showcmd " Show the command as it’s being typed
set wildmenu " Enhance command-line completion
set lazyredraw " Buffer screen updates instead of updating all the time
set laststatus=2 " Always display status line
set timeout timeoutlen=1500
set shortmess=atI
set tabstop=2
set shiftwidth=2
set expandtab " Convert tabs to spaces
set backspace=indent,eol,start
set list " Show whitespace and tabs
set listchars=tab:\¦·,trail:· " show tabs and trailing whitespace
set clipboard=unnamed " copy and paste with *
autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace
"""""""""" END General ViM Settings """"""""""



"""""""""" Plugins """"""""""
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter.git'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

Plug 'djoshea/vim-autoread'
Plug 'dracula/vim'
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0 " disable the auto-hide quotations feature

Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=',' " Redefine Emmit trigger

Plug 'mileszs/ack.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'plasticboy/vim-markdown'
let vim_markdown_preview_hotkey='<C-m>' " Remap vim markdown preview
let vim_markdown_preview_github=1 " Preview with Grip

Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

Plug 'tpope/vim-fugitive.git'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
" Use linting on save not on change
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" Enable ESLint only for JavaScript.
let b:ale_linters = ['eslint']

Plug 'othree/csscomplete.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
" highlight hex colors in color
au BufRead,BufNewFile *.scss set filetype=scss.css
au BufRead,BufNewFile *.sass set filetype=sass.css
Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

Plug 'jiangmiao/auto-pairs'

call plug#end() " Initialize plugin system
"""""""""" END Plugins """"""""""



""""""""""" clipboard copy and cut
vmap <C-x> :!pbcopy<CR>
" yanks and copies to system clipboard
vnoremap <C-c> "*y
vnoremap y "*y
vnoremap <C-v> "+p
vnoremap p "*p

""""""""" Tab indent
vnoremap <TAB> >
vnoremap <S-TAB> <
nnoremap <TAB> V >
nnoremap <S-TAB> V <

""""""""" Insert mode
imap <C-f> <Right>
imap <C-b> <Left>

" Use JXS syntax on JS files
let g:jsx_ext_required = 0


" Make Neoformat use Vims formatprg
let g:neoformat_try_formatprg = 1

" Use Prettier
" TODO: Only use if prettier.rc exist?
augroup NeoformatAutoFormat
    autocmd!
    autocmd FileType css,javascript,javascript.jsx setlocal formatprg=prettier\
                                                            \--stdin\
                                                            \--print-width\ 80\
                                                            \--single-quote\
                                                            \--trailing-comma\ es5
    autocmd BufWritePre *.css,*.js,*.jsx Neoformat
augroup END

" Setting up environment
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Change mapleader
let mapleader=","

" Customize statusbar
let g:airline_section_y = ''
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

" Use The Silver Searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

" bind \ (backward slash) to grep shortcut
  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"""""""" Fonts """"""""
set t_ZH=[3m " Support italics
set t_ZR=[23m " Support italics

hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

