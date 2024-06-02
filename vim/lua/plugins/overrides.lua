return {
  {
    -- https://github.com/hrsh7th/nvim-cmp
    "hrsh7th/nvim-cmp",
    commit = "b356f2c",
    pin = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            file_status = false,
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = { "diff", "diagnostics" },
        lualine_y = { "" },
        lualine_z = { "" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    },
  },
  --   {
  --     "echasnovski/mini.indentscope",
  --     opts = {
  --       draw = {
  --         delay = 0,
  --         animation = require("mini.indentscope").gen_animation.none(),
  --       },
  --     },
  --   },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   build = "make install_jsregexp",
  --   dependencies = {
  --     "neotab.nvim",
  --   },
  --   keys = {
  --     {
  --       "<Tab>",
  --       function()
  --         return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Plug>(neotab-out)"
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = "i",
  --     },
  --   },
  --   config = function()
  --     require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim//snippets/" })
  --   end,
  -- },
  {
    "ThePrimeagen/harpoon",
    opts = {
      tabline = true,
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = { eslint = {} },
  --     setup = {
  --       eslint = function()
  --         require("lazyvim.util").lsp.on_attach(function(client)
  --           if client.name == "eslint" then
  --             client.server_capabilities.documentFormattingProvider = true
  --           elseif client.name == "tsserver" then
  --             client.server_capabilities.documentFormattingProvider = false
  --           end
  --         end)
  --       end,
  --     },
  --   },
  -- },
}
