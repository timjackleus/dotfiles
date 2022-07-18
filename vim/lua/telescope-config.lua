local present, telescope = pcall(require, "telescope")

if not present then
	return
end

local actions = require("telescope.actions")

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
