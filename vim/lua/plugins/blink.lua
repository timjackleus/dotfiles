return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<CR>"] = { "fallback" }, -- Enter always creates new line
        ["<Tab>"] = { "accept", "fallback" }, -- Tab accepts completion
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
}
