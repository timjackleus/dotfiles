return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  opts = {
    enable_persistent_history = true,
  },
  config = function()
    require("neoclip").setup()
  end,
}
