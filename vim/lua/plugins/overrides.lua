return {
  -- file explorer
  {
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
          hide_gitignored = true,
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
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gs", vim.NIL },
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/*" },
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
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
}
