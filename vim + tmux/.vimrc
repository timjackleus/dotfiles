" Make Vim more useful
set nocompatible

" required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'
Plugin 'dracula/vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'ap/vim-css-color'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'w0rp/ale'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'tpope/vim-fugitive.git'
" Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Load up all of our plugins
if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" Use syntax highlighting
syntax enable

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Setting up environment
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Display line numbers on the left
set number

" Disable swap files creation
set noswapfile

set backupcopy=yes

" Show the (partial) command as it’s being typed
set showcmd

" Enhance command-line completion
set wildmenu

" Buffer screen updates instead of updating all the time
set lazyredraw

" Always display status line
set laststatus=2

set timeout timeoutlen=1500
set shortmess=atI
set mouse=a

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Formatting
set tabstop=2 shiftwidth=2 smarttab expandtab
set backspace=indent,eol,start

" Code folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
set foldlevel=2

" Use JXS syntax on JS files
let g:jsx_ext_required = 0

" Use linting on save not on change
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

" Enable ESLint only for JavaScript.
let b:ale_linters = ['eslint']

" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']

" Searching
set showmatch
set incsearch
set hlsearch

" Change mapleader
let mapleader=","

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" Conf files
nnoremap <leader>ez :tabnew ~/.zshrc<CR>
nnoremap <leader>sz :source ~/.zshrc<CR>
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>et :tabnew ~/.tmux.conf<CR>
nnoremap <leader>st :source ~/.tmux.conf<CR>

" Working with tabs
nnoremap <leader>nb :tabedit <C-R>=expand('%:p:h:h') . '/'<CR>
nnoremap <leader>nt :tabn<CR>
nnoremap <leader>pt :tabp<CR>
nnoremap <leader>ct :tabclose<CR>

" Shortcuts
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>a :Ack
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :nohl<CR>

" Functions
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Replace all Swedish special characters with entities.
" adapted from http://vim.wikia.com/wiki/HTML_entities
nnoremap <silent> ,r :call ReplaceSweChar()<CR>
function! ReplaceSweChar()
silent %s/Å/\&Aring;/eg
silent %s/Ö/\&Ouml;/eg
silent %s/Ä/\&Auml;/eg
silent %s/É/\&Eacute;/eg
silent %s/å/\&aring;/eg
silent %s/ö/\&ouml;/eg
silent %s/ä/\&auml;/eg
silent %s/é/\&eacute;/eg
endfunction

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Customize statusbar
let g:airline_section_y = ''
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'
