return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {},
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  providers = {
    avante_commands = {
      name = "avante_commands",
      module = "blink.compat.source",
      score_offset = 90, -- show at a higher priority than lsp
      opts = {},
    },
    avante_files = {
      name = "avante_commands",
      module = "blink.compat.source",
      score_offset = 100, -- show at a higher priority than lsp
      opts = {},
    },
    avante_mentions = {
      name = "avante_mentions",
      module = "blink.compat.source",
      score_offset = 1000, -- show at a higher priority than lsp
      opts = {},
    },
  },
}
