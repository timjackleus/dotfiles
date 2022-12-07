local present, catppuccin = pcall(require, "catppuccin")

if not present then
	return
end

catppuccin.setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
})

vim.cmd.colorscheme("catppuccin")
