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

-- COC
map("n", "<leader>.", "<Plug>(coc-codeaction)")
map("n", "<leader>l", "<cmd>CocCommand eslint.executeAutofix<CR>")
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "<leader>r", "<Plug>(coc-rename)")
map('n', '<Leader>e', '<cmd>CocCommand explorer --quit-on-open --preset floating<CR>')
map("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
map("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", { silent = true, expr = true })
map("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", { expr = true })
map("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", { silent = true, expr = true })
map("n", "gh", "<cmd>call CocActionAsync('doHover')<CR>", { silent = true })
map("n", "[g", "<cmd>call CocAction('diagnosticPrevious')<cr>")
map("n", "]g", "<cmd>call CocAction('diagnosticNext')<cr>")
map("n", "<leader>qf", "<Plug>(coc-fix-current)", { silent = true })
map("n", "[c", "<Plug>(coc-git-prevchunk)")
map("n", "]c", "<Plug>(coc-git-nextchunk)")

-- NEOGIT
map("n", "<leader>gs", "<cmd>Neogit<CR>", { silent = true })

-- GIT BLAME
map("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { silent = true })

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
