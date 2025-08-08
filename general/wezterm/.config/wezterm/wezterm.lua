local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = "Medium" })
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.keys = {
  {
    key = 'v',
    mods = 'CTRL',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  {
    key = '/',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      command = { args = { 'zsh', '-li', '-c', 'claude', '-c' } },
      size = { Percent = 50 },
    },
  },
  {
    key = '\\',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      command = { args = { 'zsh', '-l' } },
      size = { Percent = 50 },
    },
  },
}

return config
