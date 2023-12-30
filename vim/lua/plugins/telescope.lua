local theme = require("catppuccin.palettes.macchiato")
local promptBg = theme.base
local resultBg = theme.crust
local previewBg = theme.crust

-- prompt
vim.api.nvim_set_hl(0, "TelescopePromptBorder", {
  fg = promptBg,
  bg = promptBg,
})

vim.api.nvim_set_hl(0, "TelescopePromptNormal", {
  fg = theme.sky,
  bg = promptBg,
})

vim.api.nvim_set_hl(0, "TelescopePromptTitle", {
  fg = theme.sky,
  bg = promptBg,
})

vim.api.nvim_set_hl(0, "TelescopePromptCounter", {
  fg = theme.sky,
  bg = promptBg,
})

vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {
  fg = theme.sky,
  bg = promptBg,
})

-- result
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {
  fg = resultBg,
  bg = resultBg,
})

vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {
  fg = theme.sky,
  bg = resultBg,
})

vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {
  fg = resultBg,
  bg = resultBg,
})

vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", {
  fg = theme.sky,
  bg = resultBg,
})

-- preview
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {
  fg = previewBg,
  bg = previewBg,
})

vim.api.nvim_set_hl(0, "TelescopePreviewNormal", {
  fg = theme.sky,
  bg = previewBg,
})

vim.api.nvim_set_hl(0, "TelescopePreviewTitle", {
  fg = previewBg,
  bg = previewBg,
})

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>gs", vim.NIL },
  },
  cmd = "Telescope",
  opts = {
    defaults = {
      file_ignore_patterns = { "package-lock.json" },
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
        },
      },
    },
    pickers = {
      buffers = {
        sort_lastused = true,
        mappings = {
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
            ["<c-s>"] = require("telescope.actions").select_horizontal,
          },
          n = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
            ["<c-s>"] = require("telescope.actions").select_horizontal,
          },
        },
      },
    },
  },
}
