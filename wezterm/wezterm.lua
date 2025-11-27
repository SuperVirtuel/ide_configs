local wezterm = require 'wezterm'
local config = {}

-- Use a Nerd Font with fallbacks
config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font',
  'Noto Sans Symbols',
  'Noto Sans Symbols 2',
})

config.font_size = 12.0

-- Suppress missing glyph warnings (optional)
config.warn_about_missing_glyphs = false

return config
