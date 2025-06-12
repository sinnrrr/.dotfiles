local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.color_scheme = 'Tokyo Night'
config.font_size = 15
config.enable_tab_bar = false

return config
