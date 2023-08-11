-- declare hammerspoon as a global
local hs = hs

-- remove animations
hs.window.animationDuration = 0

-- set measurements and position for window
local function setMeasurements(win, position)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	if position == "left" then
		f.x = max.x
		f.y = max.y
		f.w = max.w / 2
		f.h = max.h
	elseif position == "right" then
		f.x = max.x + (max.w / 2)
		f.y = max.y
		f.w = max.w / 2
		f.h = max.h
	elseif position == "center" then
		f.x = max.x
		f.y = max.y
		f.w = max.w
		f.h = max.h
	end

	win:setFrame(f)
end

-- Helper function to position app windows
local function positionAppWindows(appName, position)
	local appWindows = hs.appfinder.appFromName(appName):allWindows()

	for _, win in pairs(appWindows) do
		setMeasurements(win, position)
	end
end

-- Helper function to position focused window
local function positionCurrentWindow(position)
	local win = hs.window.focusedWindow()

	setMeasurements(win, position)
end

-- Window setup for large monitors
hs.hotkey.bind({ "alt", "shift", "ctrl" }, "Q", function()
	positionAppWindows("Google Chrome", "left")
	positionAppWindows("Firefox", "left")
	positionAppWindows("Figma", "center")
	positionAppWindows("Alacritty", "right")
	positionAppWindows("Enpass", "right")
	positionAppWindows("Notion", "right")
	positionAppWindows("Teams", "right")
	positionAppWindows("Slack", "right")
end)

-- Window setup for laptop
hs.hotkey.bind({ "alt", "shift", "ctrl" }, "W", function()
	positionAppWindows("Google Chrome", "center")
	positionAppWindows("Firefox", "center")
	positionAppWindows("Figma", "center")
	positionAppWindows("Alacritty", "center")
	positionAppWindows("Enpass", "center")
	positionAppWindows("Notion", "center")
	positionAppWindows("Teams", "center")
	positionAppWindows("Slack", "center")
end)

hs.hotkey.bind({ "alt", "shift", "ctrl" }, "H", function()
	positionCurrentWindow("left")
end)

hs.hotkey.bind({ "alt", "shift", "ctrl" }, "L", function()
	positionCurrentWindow("right")
end)

hs.hotkey.bind({ "alt", "shift", "ctrl" }, "return", function()
	positionCurrentWindow("center")
end)
