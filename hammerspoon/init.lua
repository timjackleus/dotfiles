-- declare hammerspoon as a global
local hs = hs

-- use spothligt to find alternate names for apps
hs.application.enableSpotlightForNameSearches(true)

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
	local app = hs.appfinder.appFromName(appName)

	if not app then
		print("App not found: " .. appName)
		return
	end

	local appWindows = app:allWindows()

	for _, window in pairs(appWindows) do
		local screen = window:screen()
		local screenFrame = screen:frame()

		if screenFrame.w > 1440 then
			setMeasurements(window, position)
		else
			setMeasurements(window, "center")
		end
	end
end

-- Helper function to position focused window
local function positionCurrentWindow(position)
	local win = hs.window.focusedWindow()
	-- local nextScreen = win:screen():next();
	-- print(nextScreen

	setMeasurements(win, position)
end

-- Helper function swap screen if using multiple monitors
local function swapScreen()
	local win = hs.window.focusedWindow()
	local nextScreen = win:screen():next()
	if nextScreen then
		win:moveToScreen(nextScreen)
	end
end

-- Window setup for large monitors
hs.hotkey.bind({ "alt", "shift", "ctrl" }, "O", function()
	positionAppWindows("Google Chrome", "left")
	positionAppWindows("Arc", "left")
	positionAppWindows("Firefox", "left")
	positionAppWindows("Linear", "left")
	positionAppWindows("Figma", "center")
	positionAppWindows("Kitty", "right")
	positionAppWindows("Enpass", "right")
	positionAppWindows("Notion", "right")
	positionAppWindows("Teams", "right")
	positionAppWindows("Slack", "right")
	positionAppWindows("Notion Calendar", "right")
end)

hs.hotkey.bind({ "alt", "shift", "ctrl" }, "P", function()
	swapScreen()
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

-- Function to draw border around focused window
local border = nil
local function drawBorder()
	if border then
		border:delete()
	end

	local win = hs.window.focusedWindow()
	if win then
		local frame = win:frame()
		border = hs.drawing.rectangle(frame)
		border:setStrokeColor({
			["red"] = 0 / 255,
			["blue"] = 61 / 255,
			["green"] = 193 / 255,
			["alpha"] = 1,
		})
		border:setFill(false)
		border:setStrokeWidth(10)
		border:show()
	end
end

-- Setup border for focused window
hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function()
	drawBorder()
end)
