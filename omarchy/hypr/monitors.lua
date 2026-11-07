-- Linked to ~/.config/hypr/monitors.lua on the Dell XPS 13 9380 by setup.sh.
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 3
local omarchy_monitor_scale = 3

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

local function read_dmi(name)
  local file = io.open("/sys/class/dmi/id/" .. name, "r")
  if not file then
    return nil
  end
  local value = file:read("*l")
  file:close()
  return value
end

if read_dmi("sys_vendor") == "Dell Inc." and read_dmi("product_name") == "XPS 13 9380" then
  -- Keep this connector rule on one line: Omarchy's clamshell handler parses
  -- monitors.lua as text and cannot follow requires or description selectors.
  -- GTK requires an integer; use the nearest whole factor, as Omarchy does.
  hl.env("GDK_SCALE", "3")
  hl.monitor({ output = "eDP-1", mode = "3840x2160@60", position = "auto", scale = 2.5 })
end

-- BEGIN io.github.fluffet.display (managed by the Display panel, do not edit)
hl.monitor({ output = "desc:AU Optronics 0x282B", mode = "3840x2160@60.00", position = "2816x0", scale = 2.5, transform = 0 })
hl.monitor({ output = "desc:Dell Inc. DELL U2723QE FJ4P5P3", mode = "3840x2160@60.00", position = "4352x0", scale = 1.5, transform = 0 })
-- END io.github.fluffet.display
