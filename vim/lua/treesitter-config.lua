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
		"python",
		"rust",
		"scss",
		"svelte",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	context_commentstring = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
}

treesitter.setup(options)
