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
Plug 'Shougo/denite.nvim'
Plug 'djoshea/vim-autoread'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
let g:vim_json_syntax_conceal = 0 " disable the auto-hide quotations feature

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=',' " Redefine Emmit trigger

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

Plug 'Shougo/neosnippet.vim'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Hide conceal markers
let g:neosnippet#enable_conceal_markers = 0

"let g:neosnippet#enable_completed_snippet = 1
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
" imap <C-f> <Right>
" imap <C-b> <Left>




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


nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>t :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty -mode=normal<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

"""""""""" END Custom key bindings """"""""""




"""""""""" Fizzy File Searching """"""""""
" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Open file commands
call denite#custom#map('insert,normal', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert,normal', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('insert,normal', "<C-h>", '<denite:do_action:split>')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'prompt': 'λ:',
\ 'direction': 'rightbelow',
\ 'winminheight': '10',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry
"""""""""" END Fizzy File Searching """"""""""




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

