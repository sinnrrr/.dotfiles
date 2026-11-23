local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local shell = os.getenv("SHELL") or "/bin/sh"

config.default_cwd = wezterm.home_dir .. "/Work"
config.unix_domains = { { name = "unix" } }
config.default_gui_startup_args = { "connect", "unix" }

config.font = wezterm.font_with_fallback({ { family = "JetBrainsMono Nerd Font", weight = "DemiBold" }, "Menlo" })
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "RESIZE"
config.window_frame = {
	font = wezterm.font_with_fallback({ { family = "JetBrainsMono Nerd Font", weight = "ExtraBold" }, { family = "Menlo", weight = "Bold", scale = 1.3 } }),
	font_size = 13,
}
config.font_size = 15
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
local title_icons = {
	{ "^Yazi → lazygit: ", "\u{f024b} → \u{e727} " },
	{ "^lazygit: ", "\u{e727} " },
	{ "^lg ", "\u{e727} " },
	{ "^Yazi: ", "\u{f024b} " },
}

wezterm.on("format-tab-title", function(tab)
	local title = tab.tab_title ~= "" and tab.tab_title or tab.active_pane.title
	if title == "" then
		local cwd = tab.active_pane.current_working_dir
		title = "\u{f0169} " .. (cwd and cwd.file_path:match("([^/]+)/?$") or "")
	end
	if tab.tab_title == "claude-busy" then
		title = tab.active_pane.title:gsub("^[\128-\255]*%s*", "%0\u{f06a9} ", 1)
	end
	for _, rule in ipairs(title_icons) do
		local replaced, count = title:gsub(rule[1], rule[2])
		if count > 0 then
			title = replaced
			break
		end
	end
	return " " .. (tab.tab_index + 1) .. ": " .. title .. " "
end)

wezterm.on("gui-attached", function()
	wezterm.time.call_after(0.5, function()
		for _, window in ipairs(wezterm.gui.gui_windows()) do
			local dims = window:get_dimensions()
			window:set_inner_size(dims.pixel_width, dims.pixel_height - 1)
		end
	end)
end)

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
