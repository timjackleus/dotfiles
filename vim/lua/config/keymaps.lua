-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local v = vim
local map = v.keymap.set

-- BASICS
map("n", "vs", "<cmd>vs<CR>")
map("n", "sp", "<cmd>sp<CR>")
map("n", "<C-S>", ":%s/")
map("t", "<Esc>", "<C-\\><C-n>", { silent = true })
map("n", "<C-P>", "<C-^>")

-- move highlighted rows
map("n", "]q", "<cmd>cnext<CR>")
map("n", "[q", "<cmd>cprev<CR>")

-- move highlighted rows
map("v", "K", ":m	'<-2<CR>gv=gv")
map("v", "J", ":m	'>+1<CR>gv=gv")

-- use m to scroll down, and keep cursor in middle
map("n", "<C-m>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- keep cursor position after join line
map("n", "J", "mzJ`z")

-- yank to clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- NEOGIT
map("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true })

-- HARPOON
map("n", "<Leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = "harpoon - mark" })
map("n", "<c-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "harpoon - toggle menu" })
map("n", "<c-f>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "harpoon - nav file 1" })
map("n", "<c-d>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "harpoon - nav file 2" })
map("n", "<c-s>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "harpoon - nav file 3" })
map("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = "harpoon - next file" })
map("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = "harpoon - prev file" })

-- TELESCOPE
map("n", "<leader>fk", "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
map("n", "<leader>pr", "<cmd>lua require('telescope').extensions.gh.pull_request()<CR>")
map("n", "<leader>fq", "Telescope quickfix<CR>", { noremap = true, silent = true })

-- TMUX_NAVIGATOR
map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
map("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })
