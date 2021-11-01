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

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/switch.vim'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
Plug 'djoshea/vim-autoread'
Plug 'itchyny/lightline.vim'
Plug 'jreybert/vimagit'
Plug 'justinmk/vim-sneak'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'liuchengxu/vim-which-key'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim',
" Install plugins
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-svelte',
  \ 'coc-tsserver',
  \ 'coc-yaml']
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/context_filetype.vim'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'TimUntersberger/neogit'
Plug 'tpope/vim-abolish' " Convert to camelCase etc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'wesQ3/vim-windowswap'
call plug#end() " Initialize plugin system
