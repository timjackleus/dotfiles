function is_macos_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  -- If result contains "Dark", then dark mode is enabled, otherwise it's not
  return string.find(result, "Dark") and true or false
end

local colors_dark = {
  Base = "#191724",
  Surface = "#1f1d2e",
  Overlay = "#26233a",
  Muted = "#6e6a86",
  Subtle = "#908caa",
  Text = "#e0def4",
  Love = "#eb6f92",
  Gold = "#f6c177",
  Rose = "#ebbcba",
  Pine = "#31748f",
  Foam = "#9ccfd8",
  Iris = "#c4a7e7",
  Highlight_Low = "#21202e",
  Highlight_Med = "#403d52",
  Highlight_High = "#524f67",
}

local colors_light = {
  Base = "#faf4ed",
  Surface = "#fffaf3",
  Overlay = "#f2e9e1",
  Muted = "#9893a5",
  Subtle = "#797593",
  Text = "#575279",
  Love = "#b4637a",
  Gold = "#ea9d34",
  Rose = "#d7827e",
  Pine = "#286983",
  Foam = "#56949f",
  Iris = "#907aa9",
  Highlight_Low = "#f4ede8",
  Highlight_Med = "#dfdad9",
  Highlight_High = "#cecacd",
}

local colors = is_macos_dark_mode() and colors_dark or colors_light

return colors
