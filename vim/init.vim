scriptencoding utf-8
source ~/.config/nvim/plugins.vim

"""""""""" General ViM Settings """"""""""
filetype plugin indent on
syntax on " Use syntax highlighting

set cursorline " highlight current line
set expandtab " Convert tabs to spaces
set hidden " keep undo history of files when switching buffer
set ignorecase " " ignore upper/lower case when searching
set list " Show whitespace and tabs
set listchars=tab:\¦·,trail:· " show tabs and trailing whitespace
set mouse=a " Scrollable term-vim
set nofoldenable " disable folding
set noswapfile " Disable swap files creation
set number " Display line numbers on the left
set omnifunc=syntaxcomplete#Complete " Use Autocomplete
set relativenumber
set report=0 " tell us when anything is changed via :...
set scrolloff=3 " Keep 3 lines (top/bottom) for scope
set shiftwidth=2
set shortmess=atI
set tabstop=2
set termguicolors
set timeout timeoutlen=1000
set updatetime=100 " Update sign column every quarter second
set splitright " Always open new splits to the right
autocmd BufWritePre * %s/\s\+$//e " trim trailing whitespace

" coc.nvim recommendations
set cmdheight=2 " Better display for messages
set nobackup " Some servers have issues with backup files
set nowritebackup
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.

" Setup a decent find
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
""""""""" END General ViM Settings """"""""""



"""""""""" Plugin settings """"""""""
" codi.vim
let g:codi#aliases = {
\ 'javascript.jsx': 'javascript',
\ }

" emmet-vim
let g:user_emmet_leader_key=',' " Redefine Emmit trigger

" vim-markdown
let vim_markdown_preview_hotkey='<C-m>' " Remap vim markdown preview
let vim_markdown_preview_github=1 " Preview with Grip

" nerdtree
let NERDTreeShowHidden=1
" :NERDTree is the only way to activete the setting bellow
let g:NERDTreeWinSize=30
" Close nerdtree when file is opened
let NERDTreeQuitOnOpen=1

" coc-pairs
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" coc.nvim
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc-prettier
" run on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" run manually
command! -nargs=0 CocPrettier :CocCommand prettier.formatFile

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#var('buffer', 'date_format', '')
call denite#custom#map('insert,normal', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert,normal', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('insert,normal', "<C-h>", '<denite:do_action:split>')

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
"""""""""" END Plugins settings """"""""""



"""""""""" Theme """"""""""
let g:onedark_terminal_italics = 1
let g:vim_json_syntax_conceal = 0 " disable the auto-hide quotations feature (onedark.vim)
colorscheme onedark

let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \ 'right': [ [ 'lineinfo' ],
  \            ['gitbranch']]
  \},
  \'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \}

command! LightlineReload call LightlineReload()

function! LightlineReload()
  call lightline#enable()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction


" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
"""""""""" END Theme """"""""""



"""""""""" Custom key bindings """"""""""
" Change mapleader
let mapleader = "\<Space>"

" nerdtree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

" Tab indent
vnoremap <TAB> >
vnoremap <S-TAB> <
nnoremap <TAB> V >
nnoremap <S-TAB> V <

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
nmap <leader>vr :vsp ~/.config/nvim/init.vim<CR>

" source init.vim
nmap <Leader>so :so ~/.config/nvim/init.vim<CR>

" Inactivate arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" codi.vim
map <Leader>c :Codi!! javascript<CR>

" Replace all Swedish special characters with entities.
" adapted from http://vim.wikia.com/wiki/HTML_entities
nnoremap <silent> ,r :call ReplaceSweChar()<CR>
function! ReplaceSweChar()
  silent set noignorecase
  silent %s/Å/\&Aring;/eg
  silent %s/Ö/\&Ouml;/eg
  silent %s/Ä/\&Auml;/eg
  silent %s/É/\&Eacute;/eg
  silent %s/å/\&aring;/eg
  silent %s/ö/\&ouml;/eg
  silent %s/ä/\&auml;/eg
  silent %s/é/\&eacute;/eg
  silent set ignorecase
endfunction

" Denite mappings
nmap <leader>b :Denite buffer<CR>
nmap <leader>f :DeniteProjectDir file/rec<CR>
nnoremap <leader>/ :<c-u>Denite grep:. -no-empty<CR>
nnoremap <leader>k :<c-u>DeniteCursorWord grep:.<CR>

" Define mappings while in denite 'filter' mode
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
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> <c-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <c-s>
  \ denite#do_map('do_action', 'split')
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

" coc.nvim

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gx <Plug>(coc-codeaction)

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)

" Select a function
xmap <leader> if <Plug>(coc-funcobj-i)
xmap <leader> af <Plug>(coc-funcobj-a)

" Show documentation.
nnoremap <silent> gh :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

"  coc-snippets
"  bind tab key ussage as for VSCode snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
""""""""" END Custom key bindings """"""""""



"""""""" Fonts """"""""
" set t_ZH=[3m " Support italics
" set t_ZR=[23m " Support italics

" hi htmlArg gui=italic
" hi Comment gui=italic
" hi Type    gui=italic
" hi htmlArg cterm=italic
" hi Comment cterm=italic
" hi Type    cterm=italic
"""""""" END Fonts """"""""
