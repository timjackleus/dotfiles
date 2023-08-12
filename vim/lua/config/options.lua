local vset = vim.opt

vim.g.gitblame_enabled = 0

vset.list = false
vset.hidden = true
vset.swapfile = false
vset.clipboard = "" -- dont save to clipboard

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

return {
  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "fish",
        "go",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "svelte",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
}
