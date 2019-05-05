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
autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace
"""""""""" END General ViM Settings """"""""""




"""""""""" Plugins """"""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

Plug 'djoshea/vim-autoread'
Plug 'joshdick/onedark.vim'

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

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_section_y = ''
let g:airline_powerline_fonts = 1
let g:nord_cursor_line_number_background = 1
"let g:airline_theme='minimalist'
" Underline support
let g:nord_underline = 1

Plug 'w0rp/ale'
" Use linting on save not on change
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" Enable ESLint only for JavaScript.
let b:ale_linters = ['eslint']

Plug 'prettier/vim-prettier'
let g:prettier#autoformat = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
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
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<c-k>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

call plug#end() " Initialize plugin system
"""""""""" END Plugins """"""""""




"""""""""" Theme """"""""""
let g:onedark_terminal_italics=1
colorscheme onedark
"""""""""" END Theme """"""""""

" Tab indent
vnoremap <TAB> >
vnoremap <S-TAB> <
nnoremap <TAB> V >
nnoremap <S-TAB> V <

" Insert mode
imap <C-f> <Right>
imap <C-b> <Left>

" Change mapleader
let mapleader=","




""""""""" Javascript """""""""

" Use JXS syntax on JS files
let g:jsx_ext_required = 0



""""""""" END Javascript """""""""



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

