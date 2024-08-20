local wt = require 'wezterm'

local config = {}

config.color_scheme = 'Sea Shells (Gogh)'
config.font_size = 18

-- history scrollback 10000
config.scrollback_lines = 10000

-- alt key handling to allow umlaute
config.send_composed_key_when_left_alt_is_pressed = true

-- remove title bar and tabs
config.window_decorations = 'RESIZE'
config.enable_tab_bar = false

-- maybe window padding
config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 15,
}

config.keys = {
}


return config
