"""""""""" General ViM Settings """"""""""
filetype plugin indent on
syntax on " Use syntax highlighting

set hidden " keep undo history of files when switching buffer
set clipboard=unnamed
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
set timeout timeoutlen=1000
set termguicolors
set relativenumber
autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace

" coc.nvim recommendations
set nobackup " Some servers have issues with backup files
set nowritebackup
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns

" Setup a decent find
set path+=**
set wildmenu
set wildignore+=**/node_modules/**

""""""""" END General ViM Settings """"""""""


" Change mapleader
let mapleader = "\<Space>"


"""""""""" Plugins """"""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
set updatetime=100 " Update sign column every quarter second

Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs' " Auto-create closing brackets
Plug 'jreybert/vimagit'
Plug 'tpope/vim-commentary'
Plug 'metakirby5/codi.vim'

let g:codi#aliases = {
\ 'javascript.jsx': 'javascript',
\ }

map <Leader>c :Codi!! javascript<CR>


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
" :NERDTree is the only way to activete the setting bellow
let g:NERDTreeWinSize=30
" Close nerdtree when files is opened
let NERDTreeQuitOnOpen=1
map <Leader>n :NERDTreeToggle<CR>

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Install plugins
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-neosnippet',
  \ 'coc-prettier',
  \ 'coc-tslint-plugin',
  \ 'coc-tsserver',
  \ 'coc-yaml']

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
nmap <silent> gx <Plug>(coc-codeaction)

" Select a function
xmap <leader> if <Plug>(coc-funcobj-i)
xmap <leader> af <Plug>(coc-funcobj-a)

" Show documentation.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

Plug 'Shougo/denite.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
imap <Leader>k <Plug>(neosnippet_expand_or_jump)
smap <Leader>k <Plug>(neosnippet_expand_or_jump)
xmap <Leader>k <Plug>(neosnippet_expand_target)

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

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git'])

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
\ 'split': 'floating',
\ 'start_filter': 0,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'statusline': 0,
\ 'prompt': 'λ:',
\ 'highlight_matched_char': 'WildMenu',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'StatusLine',
\ 'highlight_prompt': 'StatusLine',
\ 'winrow': 1,
\ 'vertical_preview': 1
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

" === Denite shorcuts === "
"   <leader>b         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap <leader>b :Denite buffer<CR>
nmap <leader>f :DeniteProjectDir file/rec<CR>
nmap <leader>w :Denite -start-filter file/rec<CR>
nnoremap <leader>/ :<c-u>Denite grep:. -no-empty<CR>
nnoremap <leader>k :<c-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <c-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <c-o>
  \ denite#do_map('open_filter_buffer')
endfunction



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
inoremap <C-h> <Right>
inoremap <C-l> <Left>




"""""""""" Custom key bindings """"""""""


" Bind :Q to :q
command! Q q

" Easy access to start of the line
nmap 0 ^

" Copy the entire buffer into the system register
nmap <leader>co ggVG*y

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk " git next
nmap <Leader>gp <Plug>GitGutterPrevHunk " git previous

" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk " git add (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk " git undo (chunk)

" Open vimagit pane
nmap <leader>gs :Magit<CR> " git status

" Show commits for every source line
nmap <Leader>gb :Gblame<CR>  " git blame

" Split edit init.vim
nmap <leader>vr :sp ~/.config/nvim/init.vim<CR>

" source init.vim
nmap <Leader>so :so ~/.config/nvim/init.vim<CR>
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

