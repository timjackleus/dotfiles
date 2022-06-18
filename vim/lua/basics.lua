local v = vim
local vset = v.opt

vset.cursorline = true
vset.hidden = true
vset.ignorecase = true
vset.mouse = "a"
vset.number = true -- display line numbers
vset.numberwidth = 4
vset.relativenumber = true
vset.pumheight = 20 -- limit the height of autocompletion
vset.relativenumber = true
vset.scrolloff = 3
vset.shiftwidth = 2
vset.signcolumn = "yes"
vset.splitbelow = true
vset.splitright = true
vset.swapfile = false
vset.tabstop = 2
vset.termguicolors = true

-- set.listchars = { tab = '▸ ', trail = '·'} -- highlight trailing spaces and tabs
-- set.listchars = { tab = ' ', trail = '·'} -- highlight trailing spaces and tabs

-- remove trailing whitespaces
v.cmd([[
  autocmd BufWritePre * %s/\s\+$//e
]])

v.g["netrw_banner"] = 0
v.g["netrw_liststyle"] = 3
v.g["netrw_winsize"] = 25
