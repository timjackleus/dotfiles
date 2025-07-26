-- Application shortcuts

local M = {}
local hs = hs -- declare hammerspoon as a global

-- Helper function to focus or launch application
local function focusOrLaunch(appName)
	local app = hs.appfinder.appFromName(appName)

	if app then
		-- App is running, focus it
		app:activate()

		-- If app has windows, bring the main window to front
		local windows = app:allWindows()
		if #windows > 0 then
			windows[1]:focus()
		end
	else
		-- App is not running, launch it
		hs.application.launchOrFocus(appName)
	end
end

local function addShortcut(key, appName)
	hs.hotkey.bind({ "ctrl", "alt", "cmd" }, key, function()
		focusOrLaunch(appName)
	end)
end

-- Setup function to bind all shortcuts
function M.setup()
	addShortcut("s", "Slack")
	addShortcut("c", "Ghostty")
	addShortcut("b", "Arc")
	-- also try numbers for now
	addShortcut("3", "Slack")
	addShortcut("2", "Ghostty")
	addShortcut("1", "Arc")
end

return M
