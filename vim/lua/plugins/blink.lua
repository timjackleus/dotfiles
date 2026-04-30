return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<CR>"] = { "fallback" }, -- Enter always creates new line
        ["<Tab>"] = { "accept", "fallback" }, -- Tab accepts completion
        ["<Right>"] = { LazyVim.cmp.map({ "ai_accept" }), "fallback" }, -- Right accepts inline AI ghost text when visible
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
}
