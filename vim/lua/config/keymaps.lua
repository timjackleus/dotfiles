-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- BASICS
vim.keymap.set("n", "vs", "<cmd>vs<CR>")
vim.keymap.set("n", "sp", "<cmd>sp<CR>")
vim.keymap.set("n", "<C-S>", ":%s/")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<C-P>", function()
  if vim.bo.filetype ~= "qf" then
    return "<C-^>"
  end
  return "<C-P>"
end, { expr = true })

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
vim.keymap.set("n", "<C-d>", "<C-d>zz")
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

-- NEOGIT
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { silent = true })

-- TMUX_NAVIGATOR
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })
