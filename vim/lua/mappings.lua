local v = vim
local map = v.keymap.set

-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- BASICS
map("n", "vs", "<cmd>vs<CR>")
map("n", "sp", "<cmd>sp<CR>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-S>", ":%s/")
map("t", "<Esc>", "<C-\\><C-n>", { silent = true })
map("n", "<C-P>", "<C-^>")
map("n", "<C-N>", "<cmd>luafile %<CR>", print("nvim reloaded"), { buffer = true })

--Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Copy the entire buffer into the system register
map("n", "<leader>co", "<cmd>%y<CR>", { silent = true })

-- Copy the entire buffer into the clipboard
map("n", "<leader>cy", "<esc>ggVGcp<CR>", { silent = true })

-- NEOGIT
map("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true })

-- GIT BLAME
map("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { silent = true })

-- NVIM TREE
map("n", "<leader>e", "<cmd>NeoTreeFloatToggle<CR>", { silent = true })

-- TELESCOPE
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
map("n", "<Leader>/", "<cmd>Telescope live_grep<CR>", { silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
map("n", "<leader>fk", "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
map("n", "<leader>pr", "<cmd>lua require('telescope').extensions.gh.pull_request()<CR>")

--- SPECTRE (search and replace)
map("n", "<leader>sr", "<cmd>lua require('spectre').open()<CR>")
map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")

-- GLOW - Preview markdown files
map("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true })

-- EMMET
-- vim.g.user_emmet_leader_key = ","

-- HARPOON
map("n", "<Leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = "harpoon - mark" })
map("n", "<Leader>hm", "<cmd>Telescope harpoon marks<CR>", { desc = "harpoon - toggle menu" })
map("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = "harpoon - next file" })
map("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = "harpoon - prev file" })

-- HOP
map("n", "ss", "<cmd>lua require'hop'.hint_char2({})<CR>")
map("n", "<leader>sv", "<cmd>lua require'hop'.hint_lines({})<CR>")
