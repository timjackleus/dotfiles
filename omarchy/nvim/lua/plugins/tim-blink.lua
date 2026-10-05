return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
        ["<Right>"] = { LazyVim.cmp.map({ "ai_accept" }), "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
}
