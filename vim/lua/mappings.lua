local v = vim
local map = v.api.nvim_set_keymap

-- BASICS
map('n', 'vs', ':vs<CR>', { noremap = true })
map('n', 'sp', ':sp<CR>', { noremap = true })
map('n', '<C-L>', '<C-W><C-L>', { noremap = true })
map('n', '<C-H>', '<C-W><C-H>', { noremap = true })
map('n', '<C-K>', '<C-W><C-K>', { noremap = true })
map('n', '<C-J>', '<C-W><C-J>', { noremap = true })
map('n', '<C-S>', ':%s/', { noremap = true })

map("t", "<Esc>", "<C-\\><C-n>", {noremap = true, silent = true})
map("n", "<C-P>", "<C-^>", {noremap = true })

-- COC
map("n", "<leader>.", "<Plug>(coc-codeaction)", {})
map("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})
map("n", "gd", "<Plug>(coc-definition)", {silent = true})
map("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
map("n", "<leader>rn", "<Plug>(coc-rename)", {})
map('n', '<Leader>e', ':CocCommand explorer --quit-on-open --preset floating<CR>', {noremap = true})
map("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
map("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
map("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
map("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

-- NEOGIT
map("n", "<leader>gs", ":Neogit<CR>", { noremap = true, silent = true})

-- Git blame
map("n", "<leader>gb", ":GitBlameToggle<CR>", { noremap = true, silent = true })

-- TELESCOPE
map('n', '<leader>f', "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", { noremap = true })
map('n', '<leader>/', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
map('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
map('n', '<leader>pr', "<cmd>lua require('telescope').extensions.gh.pull_request()<CR>", { noremap = true })

--- SPECTRE
map('n', '<leader>sr', "<cmd>lua require('spectre').open()<CR>", { noremap = true })
map('n', '<leader>sw', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { noremap = true })

