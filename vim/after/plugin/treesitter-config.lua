local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
	return
end

local options = {
	ensure_installed = {
		"bash",
		"css",
		"dockerfile",
		"fish",
		"go",
		"html",
		"http",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"php",
		"python",
		"rust",
		"scss",
		"svelte",
		"tsx",
		"typescript",
		"vim",
		"yaml",
		"markdown",
		"rust",
	},
	auto_install = true,
	highlight = { enable = true },
	context_commentstring = { enable = true },
	indent = { enable = true },
}

treesitter.setup(options)
