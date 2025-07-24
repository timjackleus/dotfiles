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

-- Setup function to bind all shortcuts
function M.setup()
	hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "s", function()
		focusOrLaunch("Slack")
	end)
	hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "c", function()
		focusOrLaunch("Ghostty")
	end)
	hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "b", function()
		focusOrLaunch("Arc")
	end)
end

return M
