local present, telescope = pcall(require, "telescope")
if not present then
	return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.load_extension("harpoon")

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".git/*" },
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer,
					["<c-s>"] = actions.select_horizontal,
				},
				n = {
					["<c-d>"] = actions.delete_buffer,
					["<c-s>"] = actions.select_horizontal,
				},
			},
		},
	},
})

-- Falling back to find_files if git_files can't find a .git directory
local project_files = function()
	local opts = { noremap = true, silent = true } -- define here if you want to define something
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

vim.keymap.set("n", "<Leader>fg", project_files, { noremap = true, silent = true })
