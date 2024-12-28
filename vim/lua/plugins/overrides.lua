return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "rose-pine",
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
  -- {
  --   "L3MON4D3/LuaSnip",
  --   build = "make install_jsregexp",
  --   dependencies = {
  --     "neotab.nvim",
  --   },
  --   keys = {},
  --   config = function()
  --     require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/" })
  --   end,
  -- },
}
