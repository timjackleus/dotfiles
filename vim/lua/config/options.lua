-- avoid root directory suddenly change
vim.g.root_spec = { "cwd" }

vim.opt.list = false
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.clipboard = "" -- dont save to clipboard
vim.opt.conceallevel = 0
vim.opt.laststatus = 3

-- vim.g.ai_cmp = false -- disable showing copilot complitions in blink, it will be shown with ghost text instead

vim.g.snacks_animate = false -- stop scroll animation

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
