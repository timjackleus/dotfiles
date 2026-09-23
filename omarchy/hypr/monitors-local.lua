-- Installed inline in monitors.lua on the Dell XPS 13 9380 by setup.sh.
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
