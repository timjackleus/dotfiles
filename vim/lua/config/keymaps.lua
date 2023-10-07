-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local v = vim

-- BASICS
v.keymap.set("n", "vs", "<cmd>vs<CR>")
v.keymap.set("n", "sp", "<cmd>sp<CR>")
v.keymap.set("n", "<C-S>", ":%s/")
v.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
v.keymap.set("n", "<C-P>", "<C-^>")

-- remove lazyvim bindings
v.keymap.del("n", "<S-h>")
v.keymap.del("n", "<S-l>")

-- move highlighted rows
v.keymap.set("n", "]q", "<cmd>cnext<CR>")
v.keymap.set("n", "[q", "<cmd>cprev<CR>")

-- move highlighted rows
v.keymap.set("v", "K", ":m	'<-2<CR>gv=gv")
v.keymap.set("v", "J", ":m	'>+1<CR>gv=gv")

-- use m to scroll down, and keep cursor in middle
v.keymap.set("n", "<C-m>", "<C-d>zz")
v.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor position after join line
v.keymap.set("n", "J", "mzJ`z")

-- yank to clipboard
v.keymap.set("n", "<leader>y", '"+y')
v.keymap.set("v", "<leader>y", '"+y')
v.keymap.set("n", "<leader>Y", '"+Y')

-- NEOGIT
v.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true })

-- HARPOON
v.keymap.set("n", "<Leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = "harpoon - mark" })
v.keymap.set(
  "n",
  "<leader>he",
  "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
  { desc = "harpoon - toggle menu" }
)
v.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "harpoon - nav file 1" })
v.keymap.set("n", "<leader>hs", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "harpoon - nav file 2" })
v.keymap.set("n", "<leader>hd", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "harpoon - nav file 3" })
v.keymap.set("n", "<leader>hf", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "harpoon - nav file 4" })
v.keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = "harpoon - next file" })
v.keymap.set("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = "harpoon - prev file" })

-- TELESCOPE
v.keymap.set("n", "<leader>fk", "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
v.keymap.set("n", "<leader>pr", "<cmd>lua require('telescope').extensions.gh.pull_request()<CR>")
v.keymap.set("n", "<leader>fq", "Telescope quickfix<CR>", { noremap = true, silent = true })

-- TMUX_NAVIGATOR
v.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
v.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
v.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
v.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
v.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
v.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })
