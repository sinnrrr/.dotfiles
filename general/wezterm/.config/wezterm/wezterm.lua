local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "RESIZE"
config.font_size = 15
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.keys = {
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Right",
			command = { args = { "/opt/homebrew/bin/fish", "-lc", "ai" } },
			size = { Percent = 50 },
			cwd = wezterm.GLOBAL.current_working_dir,
		}),
	},
	{
		key = "/",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Down",
			command = { args = { "/opt/homebrew/bin/fish", "-l" } },
			size = { Percent = 50 },
			cwd = wezterm.GLOBAL.current_working_dir,
		}),
	},
	{
		key = "n",
		mods = "CTRL",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "q",
		mods = "CTRL",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "h",
		mods = "CTRL",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "CTRL",
		action = act.ActivateTabRelative(1),
	},
}

return config
