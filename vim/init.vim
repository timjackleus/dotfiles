scriptencoding utf-8
source ~/.config/nvim/plugins.vim

"""""""""" General ViM Settings """"""""""
filetype plugin indent on

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
set timeout timeoutlen=500
set updatetime=100 " Update sign column every quarter second
set splitright " Always open new splits to the right
set pumheight=20 " Limit the height of autocompletions
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

" switch.vim
let g:switch_custom_definitions =
    \ [
    \   ['foo', 'bar', 'baz'],
    \   ['true', 'false']
    \ ]

" codi.vim
let g:codi#aliases = {
\ 'javascript.jsx': 'javascript',
\ }

" emmet-vim
let g:user_emmet_leader_key=',' " Redefine Emmit trigger

" vim-markdown
let vim_markdown_preview_hotkey='<C-m>' " Remap vim markdown preview
let vim_markdown_preview_github=1 " Preview with Grip

" coc-explorer
" floating window setup
let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   }
\ }

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

" sneak
" let g:sneak#label = 1
let g:sneak#s_next = 1

" Telescope
" Avoid insert mode at first esc
  lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF
"""""""""" END Plugins settings """"""""""



"""""""""" Theme """"""""""
" Avoid executing all syntax- or colorscheme-related vim configs
" for the second time (i.e., when re-sourced).
if !exists('g:syntax_on')
  syntax on
  let g:onedark_terminal_italics = 1
  let g:vim_json_syntax_conceal = 0 " disable the auto-hide quotations feature (onedark.vim)
end

if !&termguicolors
  set termguicolors
endif

if !exists('g:colors_name')
  colorscheme onedark
endif

" overrides
hi Normal guifg=#abb2bf ctermfg=249 guibg=#282c34 ctermbg=235 gui=NONE cterm=NONE
hi TabLineFill guifg=NONE ctermfg=NONE guibg=#282c34 ctermbg=235 gui=NONE cterm=NONE
hi SignColumn guifg=NONE ctermfg=NONE guibg=#282c34 ctermbg=235 gui=NONE cterm=NONE

" set color of floating windows
highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#c678dd guibg=#24282d

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

" set colors of startify
hi StartifyHeader cterm=italic guifg=#c678dd guibg=#282c34
hi StartifyNumber  guifg=#56B6C2

" activate nvim-colorizer
lua require'colorizer'.setup()

" activate treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

" Border highlight groups.
highlight TelescopeBorder         guifg=#ffffff
highlight TelescopePromptBorder   guifg=#56b6C2
highlight TelescopeResultsBorder  guifg=#61AFEF
highlight TelescopePreviewBorder  guifg=#C678DD

" colors of coc-eslint popup
hi! CocErrorSign guifg=#d1666a
" hi! CocInfoSign guibg=#353b45
hi! CocWarningSign guifg=#E5C07B

"""""""""" END Theme """"""""""



"""""""""" Custom key bindings """"""""""
" Change mapleader
let mapleader = "\<Space>"

" which-key for keymapping list
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
let g:which_key_sep = '→'
let g:which_key_map['/'] = 'global search'
let g:which_key_map['co'] = 'copy buffer to register'
let g:which_key_map['cp'] = 'copy buffer to clipboard'
let g:which_key_map['cj'] = 'codi js'
let g:which_key_map['b'] = 'buffers'
let g:which_key_map['e'] = 'explorer'
let g:which_key_map['f'] = 'file search'
let g:which_key_map['k'] = 'cursor word search'
let g:which_key_map['so'] = 'source vim'
let g:which_key_map['ve'] = 'vertical edit vim'
let g:which_key_map['cc'] = 'comment current line'
let g:which_key_map['r'] = 'rename'
let g:which_key_map['ww'] = 'windowswap'

let g:which_key_map['M'] = 'which_key_ignore'
let g:which_key_map['c '] = 'which_key_ignore'
let g:which_key_map['cA'] = 'which_key_ignore'

let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 's' : 'magit buffer',
      \ 'b' : 'git blame',
      \ }

let g:which_key_map.u = {
      \ 'name' : '+utils' ,
      \ 'e' : 'entities',
      \ 'o' : 'organize imports',
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

" rhubarb
nmap <Leader>gg :GBrowse<CR>

" coc-explorer
nmap <Leader>e :CocCommand explorer --quit-on-open --preset floating<CR>
" nmap <Leader>e :CocCommand explorer --position floating<CR>
" nmap <Leader>e :CocCommand explorer <CR>

" Tab indent
vnoremap <TAB> >
vnoremap <S-TAB> <
nnoremap <TAB> V >
nnoremap <S-TAB> V <

" Move visually selected lines up or down in various modes
" nnoremap I :m .-2<CR>==
" nnoremap U :m .+1<CR>==
" vnoremap I :m '<-2<CR>gv=gv
" vnoremap U :m '>+1<CR>gv=gv

" Bind :Q to :q
command! Q q

" Easy access to start of the line
nmap 0 ^

" Copy the entire buffer into the system register
nmap <leader>co <esc>ggVGy<CR>

" Copy the entire buffer into the clipboard
nmap <leader>cp <esc>ggVGcp<CR>

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Jump between hunks
nmap ]c <Plug>(GitGutterNextHunk) " git next
nmap [c <Plug>(GitGutterPrevHunk) " git previous

" Open vimagit pane
nmap <leader>gs :Magit<CR> " git status

" Show commits for every source line
nmap <Leader>gb :Git blame<CR>  " git blame

" Split edit init.vim
nmap <leader>ve :vsp ~/.config/nvim/init.vim<CR>

" source init.vim
nmap <Leader>so :so ~/.config/nvim/init.vim<CR>

" Inactivate arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" codi.vim
map <Leader>cj :Codi!! javascript<CR>

" Replace all Swedish special characters with entities.
" adapted from http://vim.wikia.com/wiki/HTML_entities
map <Leader>ue :call ReplaceSweChar()<CR>
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

" Telescope mappings
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>tc <cmd>Telescope git_commits<cr>
nnoremap <leader>tb <cmd>Telescope git_bcommits<cr>
nnoremap <leader>k <cmd>Telescope grep_string<cr>

" coc.nvim
" trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gp <Plug>(coc-implementation)
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

" autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

"  coc-snippets
"  bind tab key ussage as for VSCode snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

"organize imports of the current buffer.
nmap <leader>uo :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" jumplist keys
map <C-p> <C-^>
" unmap c-i to get the default behavior
" something is overriding it..
unmap <C-i>
""""""""" END Custom key bindings """"""""""



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

