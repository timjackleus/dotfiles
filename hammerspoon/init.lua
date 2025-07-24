-- declare hammerspoon as a global
local hs = hs

-- use spothligt to find alternate names for apps
hs.application.enableSpotlightForNameSearches(true)

-- remove animations
hs.window.animationDuration = 0

-- Import modules
local appShortcuts = require("utils/app-shortcuts")

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

local function openYaziInGhostty()
	-- Open Ghostty with Yazi
	hs.execute("open -na Ghostty.app --args -e yazi", true)

	-- Create a function to check and resize windows
	local function checkAndResizeWindows()
		-- Get all Ghostty windows
		local ghosttyWindows = hs.window.filter.new("Ghostty")
		local windows = ghosttyWindows:getWindows()

		print("Number of Ghostty windows: " .. #windows)

		-- Find the window that is not in tmux
		local yaziWindow = nil
		for _, window in pairs(windows) do
			local title = window:title() or ""
			print("Window Title: " .. title)
			print("Window Frame: " .. hs.inspect(window:frame()))

			-- Look for a window that does not contain 'tmux'
			if not string.match(title:lower(), "tmux") then
				yaziWindow = window
				break
			end
		end

		if yaziWindow then
			local screen = yaziWindow:screen():frame()

			-- Calculate window size with margins (10% margin on each side)
			local width = screen.w * 0.8
			local height = screen.h * 0.8

			-- Position the window centered
			local x = screen.x + (screen.w - width) / 2
			local y = screen.y + (screen.h - height) / 2

			local newFrame = {
				x = x,
				y = y,
				w = width,
				h = height,
			}

			-- Try to set the frame
			yaziWindow:setFrame(newFrame)

			print("Resized window: " .. (yaziWindow:title() or "No Title"))
			print("New Window Frame: " .. hs.inspect(yaziWindow:frame()))
		else
			print("No non-tmux Ghostty window found")
		end
	end

	-- Try to resize after increasing delays
	hs.timer.doAfter(0.5, checkAndResizeWindows)
	hs.timer.doAfter(1, checkAndResizeWindows)
	hs.timer.doAfter(2, checkAndResizeWindows)
end

-- Setup keymap for yazi (to replace finder)
hs.hotkey.bind({ "control", "option", "cmd" }, "e", openYaziInGhostty)

-- === INITIALIZATION ===

-- Setup app shortcuts
appShortcuts.setup()
