function is_macos_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  -- If result contains "Dark", then dark mode is enabled, otherwise it's not
  return string.find(result, "Dark") and true or false
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = function()
      local theme = require("..helpers.rosepine")
      local fileTreeBg = theme.Love
      return {
        NeoTreeFloatBorder = { fg = fileTreeBg, bg = fileTreeBg },
        NeoTreeTitleBar = { fg = fileTreeBg, bg = fileTreeBg },
        NeoTreeNormal = { fg = theme.Text, bg = fileTreeBg },
      }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine" .. (is_macos_dark_mode() and "" or "-dawn"),
    },
  },
}
