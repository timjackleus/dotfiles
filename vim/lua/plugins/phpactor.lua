return {
  "gbprod/phpactor.nvim",
  build = function()
    require("phpactor.handler.update")()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("phpactor").setup({
      lspconfig = {
        enabled = true,
        options = {
          -- Disable diagnostics while keeping other LSP features
          init_options = {
            diagnostics = false,
          },
          -- Explicitly disable diagnostics capabilities
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.publishDiagnostics = false
            capabilities.textDocument.diagnostic = false
            return capabilities
          end)(),
          -- Disable all diagnostic handlers
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end,
          },
          -- Disable diagnostics in settings
          settings = {
            phpactor = {
              diagnostics = {
                enable = false,
              },
            },
          },
        },
      },
    })
  end,
}
