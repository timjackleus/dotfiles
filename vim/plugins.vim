" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-system-copy'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'jreybert/vimagit'
Plug 'mattn/emmet-vim'
Plug 'metakirby5/codi.vim'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Install plugins
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-yaml']
Plug 'Shougo/denite.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'ianks/vim-tsx', { 'for': 'typescript.tsx' }
Plug 'sheerun/vim-polyglot'

call plug#end() " Initialize plugin system
