-- Personal options layered over Omarchy/LazyVim defaults.

-- Avoid root directory suddenly changing.
vim.g.root_spec = { "cwd" }

vim.opt.list = false
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.clipboard = "" -- Do not yank/delete to the system clipboard by default.
vim.opt.conceallevel = 0
vim.opt.laststatus = 3
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.relativenumber = false
vim.g.snacks_animate = false

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
