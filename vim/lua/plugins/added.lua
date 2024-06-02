return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("neogit").setup({})
    end,
  },
  {
    "ThePrimeagen/harpoon",
    opts = {
      vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c"),
      vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white"),
      vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7"),
      vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7"),
      vim.cmd("highlight! TabLineFill guibg=NONE guifg=white"),
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = true },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      require("lazyvim.util").lsp.on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter({})
        end
      end)
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")
      nvim_tmux_nav.setup({})
    end,
  },
}
