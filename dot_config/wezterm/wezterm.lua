local wt = require 'wezterm'

local config = {}

-- Neovim colors.
-- config.colors = {
--     foreground = "#E0E2EA",
--     background = "#14161B",
--     ansi = {
--         '#07080D',
--         '#F08080',
--         '#B3F6C0',
--         '#FCE094',
--         '#87CEFA',
--         '#ffcaff',
--         "#8cf8f7",
--         '#eef1f8',
--     },
--     brights = {
--         '#4F5258',
--         '#F08080',
--         '#B3F6C0',
--         '#FCE094',
--         '#87CEFA',
--         '#ffcaff',
--         "#8cf8f7",
--         '#eef1f8',
--     },
-- }
-- config.colors.cursor_bg = config.colors.foreground
-- config.colors.cursor_border = config.colors.foreground
-- config.colors.split = config.colors.foreground
--
-- local custom_color_scheme = wt.color.get_builtin_schemes()['Sea Shells (Gogh)']
local custom_color_scheme = wt.color.get_builtin_schemes()['nord']
-- custom_color_scheme.background = "#05181f"
-- custom_color_scheme.background = "#16252c"
-- custom_color_scheme.background = "#081826"
custom_color_scheme.background = "#20252c"

config.color_schemes = {
  ['Custom'] = custom_color_scheme
}
config.color_scheme = 'Custom'

config.font_size = 18

-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- history scrollback 10000
config.scrollback_lines = 10000

-- alt key handling to allow umlaute
config.use_dead_keys = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true


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

-- config.debug_key_events = true

return config
