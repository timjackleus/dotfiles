hl.unbind("SUPER + SHIFT + SLASH")
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "enpass" })

hl.unbind("SUPER + CTRL + V")
o.bind("SUPER + ALT + C", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

-- Vim-style navigation alongside the existing arrow-key bindings.
-- Replaces Super+J (split), Super+K (keybindings), and Super+L (layout).
for _, binding in ipairs({
  { key = "H", direction = "l", label = "left" },
  { key = "J", direction = "d", label = "down" },
  { key = "K", direction = "u", label = "up" },
  { key = "L", direction = "r", label = "right" },
}) do
  o.rebind("SUPER + " .. binding.key, "Focus window " .. binding.label, hl.dsp.focus({ direction = binding.direction }))
  o.bind("SUPER + SHIFT + " .. binding.key, "Swap window " .. binding.label, hl.dsp.window.swap({ direction = binding.direction }))
end
