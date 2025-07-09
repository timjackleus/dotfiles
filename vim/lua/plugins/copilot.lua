-- return {
--   "zbirenbaum/copilot.lua",
--   opts = {
--     suggestion = {
--       keymap = {
--         accept = "<right>", -- usually handled by nvim-cmp / blink.cmp, but I'm setting it here as I can't get it to work together with supertab in blink
--       },
--     },
--   },
-- }
return {
  "zbirenbaum/copilot.lua",
  optional = true,
  opts = function()
    require("copilot.api").status = require("copilot.status")
  end,
}
