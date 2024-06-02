function is_macos_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  -- If result contains "Dark", then dark mode is enabled, otherwise it's not
  return string.find(result, "Dark") and true or false
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin" .. (is_macos_dark_mode() and "-mocha" or "-latte"),
    },
  },
  {
    "catppuccin",
    opts = function(_, opts)
      local isDarkMode = is_macos_dark_mode()
      local theme = require("catppuccin.palettes." .. (isDarkMode and "macchiato" or "latte"))
      local fileTreeBg = theme.crust
      local finderPromptBg = theme.base
      local finderResultBg = theme.crust
      local finderPreviewBg = theme.crust

      opts.custom_highlights = function()
        return {
          NeoTreeFloatBorder = { fg = fileTreeBg, bg = fileTreeBg },
          NeoTreeTitleBar = { fg = fileTreeBg, bg = fileTreeBg },
          NeoTreeNormal = { fg = theme.text, bg = fileTreeBg },

          TelescopePromptBorder = { fg = finderPromptBg, bg = finderPromptBg },
          TelescopePromptNormal = { fg = theme.sky, bg = finderPromptBg },
          TelescopePromptTitle = { fg = theme.sky, bg = finderPromptBg },
          TelescopePromptCounter = { fg = theme.sky, bg = finderPromptBg },
          TelescopePromptPrefix = { fg = theme.sky, bg = finderPromptBg },

          TelescopeResultsBorder = { fg = finderResultBg, bg = finderResultBg },
          TelescopeResultsNormal = { fg = theme.overlay2, bg = finderResultBg },
          TelescopeResultsTitle = { fg = finderResultBg, bg = finderResultBg },
          TelescopeSelectionCaret = { fg = theme.sky, bg = finderResultBg },

          TelescopePreviewBorder = { fg = finderPreviewBg, bg = finderPreviewBg },
          TelescopePreviewNormal = { fg = theme.sky, bg = finderPreviewBg },
          TelescopePreviewTitle = { fg = finderPreviewBg, bg = finderPreviewBg },
        }
      end
    end,
  },
}
