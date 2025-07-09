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

-- vim.filetype.add({
--   extension = {
--     mdx = "mdx",
--   },
-- })
--
-- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
-- ft_to_parser.mdx = "markdown"

return {
  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  -- { import = "lazyvim.plugins.extras.lang.typescript" },

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
        "hurl",
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
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "angular-language-server",
        "bash-debug-adapter",
        "bash-language-server",
        "chrome-debug-adapter",
        "css-lsp",
        "docker-compose-language-service",
        "dockerfile-language-server dockerls",
        "eslint-lsp",
        "eslint_d",
        "firefox-debug-adapter",
        "go-debug-adapter",
        "gofumpt",
        "goimports",
        "gopls",
        "html-lsp",
        "jq",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "mdx-analyzer",
        "prettier",
        "shfmt",
        "stylua",
        "svelte-language-server",
        "typescript-language-server",
        "yaml-language-server",
      },
    },
  },
  -- "williamboman/mason-lspconfig.nvim",
  -- opts = {
  --   automatic_installation = false,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       ["php-cs-fixer"] = {
  --         mason = false,
  --         enabled = false,
  --       },
  --       phpactor = {
  --         mason = false,
  --         enabled = false,
  --       },
  --       phpcs = {
  --         mason = false,
  --         enabled = false,
  --       },
  --       intelephense = {
  --         mason = false,
  --         enabled = false,
  --       },
  --       phpcbf = {
  --         mason = false,
  --         enabled = false,
  --       },
  --     },
  --   },
  -- },
}
