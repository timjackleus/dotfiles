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

-- move highlighted rows
map("n", "d]", ":cnext<CR>")
map("n", "d[", ":cprev<CR>")

-- move highlighted rows
map("v", "K", ":m	'<-2<CR>gv=gv")
map("v", "J", ":m	'>+1<CR>gv=gv")

-- keep cursor position after join line
map("n", "J", "mzJ`z")

-- yank to clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- dissable Q
map("n", "Q", "<nop>")

-- place next search term in vertical center
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- paste without overriding last yanked
map("x", "<leader>p", '"_dp')

--Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- search and replace in buffer
map("n", "<leader>sa", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Copy the entire buffer into the system register
map("n", "<leader>co", "<cmd>%y<CR>", { silent = true })

-- Copy the entire buffer into the clipboard
map("n", "<leader>cy", "<esc>ggVGcp<CR>", { silent = true })

-- use m to scroll down, and keep cursor in middle
map("n", "<C-m>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- NEOGIT
map("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true })

-- GIT BLAME
map("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { silent = true })

-- NVIM TREE
map("n", "<leader>e", "<cmd>NeoTreeFloatToggle<CR>", { silent = true })

-- TELESCOPE
map("n", "<Leader>ff", "<cmd>Telescope find_files hidden=true<CR>", { noremap = true, silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
map("n", "<Leader>/", "<cmd>Telescope live_grep<CR>", { silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
map("n", "<leader>fk", "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
map("n", "<leader>pr", "<cmd>lua require('telescope').extensions.gh.pull_request()<CR>")
map("n", "<leader>fq", "Telescope quickfix<CR>", { noremap = true, silent = true })

--- SPECTRE (search and replace)
map("n", "<leader>sr", "<cmd>lua require('spectre').open()<CR>")
map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")

-- GLOW - Preview markdown files
map("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true })

-- HARPOON
map("n", "<Leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = "harpoon - mark" })
map("n", "<c-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "harpoon - toggle menu" })
map("n", "<c-f>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "harpoon - nav file 1" })
map("n", "<c-d>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "harpoon - nav file 2" })
map("n", "<c-s>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "harpoon - nav file 3" })
map("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = "harpoon - next file" })
map("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = "harpoon - prev file" })

-- HOP
map("n", "ss", "<cmd>lua require'hop'.hint_char2({})<CR>")
map("n", "<leader>sv", "<cmd>lua require'hop'.hint_lines({})<CR>")
