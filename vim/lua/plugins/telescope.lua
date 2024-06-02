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
