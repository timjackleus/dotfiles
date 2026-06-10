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
  },
}
