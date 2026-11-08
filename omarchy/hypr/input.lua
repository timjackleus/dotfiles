hl.config({
  input = {
    kb_layout = "tim",
    kb_options = "",

    -- Scroll under the pointer without changing keyboard focus until clicked.
    follow_mouse = 2,
    float_switch_override_focus = 0,

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,
    },
  },
})

o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })
