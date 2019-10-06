"""""""""" General ViM Settings """"""""""
filetype plugin indent on
syntax on " Use syntax highlighting

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

Plug '/usr/local/opt/fzf' " Fzf fuzzy finder
Plug 'junegunn/fzf.vim' " Fzf vim wrapper<Paste>

" ripgrep
if executable('rg')
	let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
		set grepprg=rg\ --vimgrep
		command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" use bat to preview files in file search
let g:fzf_files_options = '--preview "(bat --color \"always\" --line-range 0:100 {} || head -'.&lines.' {})"'

" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=reverse'

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  let height = float2nr(&lines * 0.5)
  let width = float2nr(&columns * 0.6)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (centralized)
  let vertical = float2nr((&lines - height) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height
        \ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
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

nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>m :Maps<CR>
nmap <Leader>/ :Rg<Space>

Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs' " Auto-create closing brackets
Plug 'jreybert/vimagit'
Plug 'tpope/vim-commentary'
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
nmap <silent> xx <Plug>(coc-codeaction)

" Select a function
xmap <silent> if <Plug>(coc-funcobj-i)
nmap <silent> af <Plug>(coc-funcobj-a)
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
imap <C-h> <Right>
imap <C-l> <Left>




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

