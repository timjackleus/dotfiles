return {
  "gbprod/phpactor.nvim",
  build = function()
    require("phpactor.handler.update")()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- you're options coes here
  },
}
