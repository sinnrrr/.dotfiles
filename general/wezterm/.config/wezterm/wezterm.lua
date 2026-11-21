local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local shell = os.getenv("SHELL") or "/bin/sh"

config.default_cwd = wezterm.home_dir .. "/Work"

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
local file_links = require("file_links")
config.hyperlink_rules = file_links.add_to(wezterm.default_hyperlink_rules())
wezterm.on("open-uri", file_links.open_file_uri)
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = act.OpenLinkAtMouseCursor,
	},
}

config.keys = {
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{ key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
	{ key = "f", mods = "CTRL|SHIFT", action = file_links.hint_mode },
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Right",
			command = { args = { shell, "-lc", "$CODING_AGENT" } },
			size = { Percent = 50 },
		}),
	},
	{
		key = "/",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Down",
			command = { args = { shell, "-l" } },
			size = { Percent = 50 },
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
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.MoveTabRelative(1),
	},
}

return config
