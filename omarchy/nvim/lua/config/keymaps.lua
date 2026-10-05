-- Personal keymaps layered over Omarchy/LazyVim defaults.

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

pcall(vim.keymap.del, "n", "<S-h>")
pcall(vim.keymap.del, "n", "<S-l>")

vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "J", "mzJ`z")

for _, key in ipairs({ "za", "zc", "zC", "zm", "zM", "zo", "zO", "zr", "zR", "zx", "zX" }) do
  vim.keymap.set("n", key, "<Nop>", { silent = true })
end

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>/", { desc = "Replace word under cursor" })
vim.keymap.set({ "n", "v" }, "<leader>rW", function()
  return ":" .. vim.fn.line(".") .. "s/<C-r><C-w>/ /g<left><left><C-h>"
end, { expr = true, desc = "Replace word under cursor on current line" })

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { silent = true })

vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", { silent = true })
