local v = vim
local set = v.opt
v.g.mapleader = ' '

set.cursorline = true
set.hidden = true
set.ignorecase = true
set.mouse = 'a'
set.number = true -- display line numbers
set.numberwidth = 4
set.relativenumber = true
set.pumheight = 20 -- limit the height of autocompletion
set.relativenumber = true
set.scrolloff = 3
set.shiftwidth = 2
set.signcolumn = 'yes'
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 2
set.termguicolors = true
-- set.listchars = { tab = '▸ ', trail = '·'} -- highlight trailing spaces and tabs
-- set.listchars = { tab = ' ', trail = '·'} -- highlight trailing spaces and tabs

-- remove trailing whitespaces
v.cmd [[
  autocmd BufWritePre * %s/\s\+$//e
]]

v.g["netrw_banner"] = 0
v.g["netrw_liststyle"] = 3
v.g["netrw_winsize"] = 25
