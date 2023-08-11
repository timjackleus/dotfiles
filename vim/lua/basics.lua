local vset = vim.opt

vim.g.gitblame_enabled = 0

vset.cursorline = true
vset.hidden = true
-- vset.lazyredraw = true -- improve speed, not sure of downside in practice?
vset.ignorecase = true
vset.mouse = "a" -- enable mouse in all modes
vset.number = true -- display line numbers
vset.numberwidth = 4
vset.relativenumber = true
vset.pumheight = 20 -- limit the height of autocompletion
vset.scrolloff = 5
vset.shiftwidth = 2
vset.signcolumn = "yes"
vset.splitbelow = true
vset.splitright = true
vset.swapfile = false
vset.tabstop = 2
vset.termguicolors = true
vset.updatetime = 100
vset.list = false
vset.wrap = false
vset.winbar = ""
vset.wildignore:append({ "*/node_modules/*" })

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})
