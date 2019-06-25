"""""""""" General ViM Settings """"""""""
filetype plugin indent on
syntax on " Use syntax highlighting

set clipboard+=unnamedplus
set cursorline " highlight current line
set expandtab " Convert tabs to spaces
set ignorecase " " ignore upper/lower case when searching
set list " Show whitespace and tabs
set listchars=tab:\¦·,trail:· " show tabs and trailing whitespace
set mouse=a " Scrollable term-vim
set nofoldenable " disable folding
set noswapfile " Disable swap files creation
set number " Display line numbers on the left
set omnifunc=syntaxcomplete#Complete " Use Autocomplete
set report=0 " tell us when anything is changed via :...
set scrolloff=3 " Keep 3 lines (top/bottom) for scope
set shiftwidth=2
set shortmess=atI
set tabstop=2
set timeout timeoutlen=1500
set termguicolors
set relativenumber
autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace
"""""""""" END General ViM Settings """"""""""




"""""""""" Plugins """"""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
set updatetime=100 " Update sign column every quarter second

Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs' " Auto-create closing brackets
Plug 'jreybert/vimagit'
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_working_path_mode = 'r'

" Easy bindings for its various modes
map <C-b> :CtrlPBuffer<cr>
" nmap <leader>bb :CtrlPBuffer<cr>
" nmap <leader>bm :CtrlPMixed<cr>
" nmap <leader>bs :CtrlPMRU<cr>

Plug 'djoshea/vim-autoread'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
let g:vim_json_syntax_conceal = 0 " disable the auto-hide quotations feature

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=',' " Redefine Emmit trigger

Plug 'mileszs/ack.vim'
Plug 'plasticboy/vim-markdown'
let vim_markdown_preview_hotkey='<C-m>' " Remap vim markdown preview
let vim_markdown_preview_github=1 " Preview with Grip

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
nnoremap <M-(> :execute "normal \<Plug>Ysurroundiw)"<cr>

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

Plug 'Shougo/neosnippet.vim'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Hide conceal markers
let g:neosnippet#enable_conceal_markers = 0

let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#disable_runtime_snippets = {
      \   '_' : 1,
      \ }
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['javascript'] = 'javascript,javascript.jsx'

" Syntax Highlight
Plug 'sheerun/vim-polyglot'
Plug 'peitalin/vim-jsx-typescript'

call plug#end() " Initialize plugin system
"""""""""" END Plugins """"""""""




"""""""""" Theme """"""""""
let g:onedark_terminal_italics = 1
colorscheme onedark

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

"""""""""" END Theme """"""""""

" Tab indent
vnoremap <TAB> >
vnoremap <S-TAB> <
nnoremap <TAB> V >
nnoremap <S-TAB> V <

" Insert mode
imap <C-f> <Right>
imap <C-b> <Left>




"""""""""" Custom key bindings """"""""""

" Change mapleader
let mapleader = "\<Space>"

" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk " git next
nmap <Leader>gp <Plug>GitGutterPrevHunk " git previous
" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk " git add (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk " git undo (chunk)

" Open vimagit pane
nnoremap <leader>gs :Magit<CR> " git status

" Show commits for every source line
nnoremap <Leader>gb :Gblame<CR>  " git blame

" source init.vim
nnoremap <Leader>sc :so ~/.config/nvim/init.vim<CR>
"""""""""" END Custom key bindings """"""""""

""""""""" Global Search """""""""

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
""""""""" END Global Search """""""""




"""""""" Fonts """"""""
set t_ZH=[3m " Support italics
set t_ZR=[23m " Support italics

hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic
"""""""" END Fonts """"""""

" Inactivate arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

