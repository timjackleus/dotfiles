local present, catppuccin = pcall(require, "catppuccin")

if not present then
	return
end

catppuccin.setup({})

require("lualine").setup({
	options = {
		theme = "catppuccin",
	},
})

-- initialize theme
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd([[colorscheme catppuccin]])
