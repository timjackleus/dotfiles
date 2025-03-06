local theme = require("..helpers.rosepine")
local windowBg = theme.Surface

vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", {
  fg = windowBg,
  bg = windowBg,
})

vim.api.nvim_set_hl(0, "NeoTreeTitleBar", {
  fg = windowBg,
  bg = windowBg,
})

vim.api.nvim_set_hl(0, "NeoTreeNormal", {
  fg = theme.Text,
  bg = windowBg,
})

return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle reveal float<cr>" },
  },
  cmd = "Neotree",
  opts = {
    window = {
      position = "left",
      toggle = true,
      mappings = {
        ["l"] = "open",
        ["h"] = "open",
        ["<c-s>"] = "open_split",
        ["<c-v>"] = "open_vsplit",
        ["<esc>"] = "close_window",
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { "node_modules" },
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          --auto close
          require("neo-tree").close_all()
        end,
      },
    },
  },
}
