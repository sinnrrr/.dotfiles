local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
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
config.keys = {{
    key = 'v',
    mods = 'CTRL',
    action = wezterm.action.PasteFrom 'Clipboard',
},
  {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
  {
    key = '\\',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      command = { args = { '/opt/homebrew/bin/fish', '-lc', 'ai' } },
      size = { Percent = 50 },
      cwd = wezterm.GLOBAL.current_working_dir,
    }
  },
  {
    key = '/',
    mods = 'CTRL',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      command = { args = { '/opt/homebrew/bin/fish', '-l' } },
      size = { Percent = 50 },
      cwd = wezterm.GLOBAL.current_working_dir,
    },
  }
}

return config
