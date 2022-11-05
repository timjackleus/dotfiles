local present, telescope = pcall(require, "telescope")

if not present then
	return
end

local M = {}

local actions = require("telescope.actions")

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
					["<c-d>"] = require("telescope.actions").delete_buffer,
					["<c-s>"] = require("telescope.actions").select_horizontal,
				},
				n = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
					["<c-s>"] = require("telescope.actions").select_horizontal,
				},
			},
		},
	},
})

-- Falling back to find_files if git_files can't find a .git directory
M.project_files = function()
	local opts = {} -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

return M
