local v = vim
local map = v.keymap.set

vim.g.user_emmet_leader_key = ','

-- BASICS
map('n', 'vs', '<cmd>vs<CR>')
map('n', 'sp', '<cmd>sp<CR>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-S>', '<cmd>%s/')
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map("t", "<Esc>", "<C-\\><C-n>", { silent = true})
map("n", "<C-P>", "<C-^>")

-- Copy the entire buffer into the system register
map("n", "<leader>co", "<esc>ggVGy<CR>", { silent = true})
-- Copy the entire buffer into the clipboard
map("n", "<leader>cp", "<esc>ggVGcp<CR>", { silent = true})

-- NEOGIT
map("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true })

-- GIT BLAME
map("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { silent = true })

-- NVIM TREE
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true })

-- TELESCOPE
-- map('n', '<leader>f', "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>")
map('n', '<leader>f', "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>")
map('n', '<leader>/', "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>")
map('n', '<leader>k', "<cmd>lua require('telescope.builtin').grep_string()<CR>")
map('n', '<leader>pr', "<cmd>lua require('telescope').extensions.gh.pull_request()<CR>")
--- SPECTRE
map('n', '<leader>sr', "<cmd>lua require('spectre').open()<CR>")
map('n', '<leader>sw', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")

-- GLOW - Preview markdown files
map("n", "<leader>mp", "<cmd>Glow<CR>", { silent = true})
