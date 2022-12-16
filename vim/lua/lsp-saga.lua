local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.init_lsp_saga({
	symbol_in_winbar = {
		in_custom = true,
	},
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "ge", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "[e", function()
	require("lspsaga.diagnostic").goto_prev()
end, opts)
vim.keymap.set("n", "]e", function()
	require("lspsaga.diagnostic").goto_next()
end, opts)
-- for new keyboard
vim.keymap.set("n", "dp", function()
	require("lspsaga.diagnostic").goto_prev()
end, opts)
vim.keymap.set("n", "dn", function()
	require("lspsaga.diagnostic").goto_next()
end, opts)

-- vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
-- vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
-- vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
