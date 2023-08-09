-- declare hammerspoon as a global
local hs = hs

-- Helper function to position app windows
local function positionAppWindows(appName, position)
	local appWindows = hs.appfinder.appFromName(appName):allWindows()

	for _, win in pairs(appWindows) do
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
