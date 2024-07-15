-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- BASICS
vim.keymap.set("n", "vs", "<cmd>vs<CR>")
vim.keymap.set("n", "sp", "<cmd>sp<CR>")
vim.keymap.set("n", "<C-S>", ":%s/")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<C-P>", "<C-^>")

-- remove lazyvim bindings
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- move highlighted rows
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>")

-- move highlighted rows
vim.keymap.set("v", "K", ":m	'<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m	'>+1<CR>gv=gv")

-- use m to scroll down, and keep cursor in middle
vim.keymap.set("n", "<C-m>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor position after join line
vim.keymap.set("n", "J", "mzJ`z")

-- yank to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- multicursor alternative
vim.keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>/", { desc = "Replace word under cursor" })
vim.keymap.set({ "n", "v" }, "<leader>rW", function()
  return ":" .. vim.fn.line(".") .. "s/<C-r><C-w>/ /g<left><left><C-h>"
end, { expr = true, desc = "Replace word under cursor on current line" })

-- HARPOON
vim.keymap.set("n", "<Leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>")
vim.keymap.set("n", "<leader>he", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
vim.keymap.set("n", "<C-z>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "harpoon - nav file 1" })
vim.keymap.set("n", "<C-x>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "harpoon - nav file 2" })
vim.keymap.set("n", "<C-c>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "harpoon - nav file 3" })
vim.keymap.set("n", "<C-v>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "harpoon - nav file 4" })
vim.keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = "harpoon - next file" })
vim.keymap.set("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = "harpoon - prev file" })

-- NEOGIT
vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true })

-- TELESCOPE
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", "<cmd>Telescope neoclip<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { noremap = true, silent = true })

-- TMUX_NAVIGATOR
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })
