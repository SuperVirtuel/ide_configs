local wezterm = require 'wezterm'
local act = wezterm.action

-- Use config builder if available
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- Use a Nerd Font with fallbacks
config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font',
  'Noto Sans Symbols',
  'Noto Sans Symbols 2',
})

config.font_size = 12.0

-- Suppress missing glyph warnings (optional)
config.warn_about_missing_glyphs = false

-- Vim-like keybindings for WezTerm
-- Designed to work in sandbox mode and be portable across all machines
config.keys = {
  -- Pane navigation: Alt+hjkl
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection('Right') },

  -- Pane resizing: Alt+Shift+hjkl
  { key = 'h', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Left', 3 }) },
  { key = 'j', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Down', 3 }) },
  { key = 'k', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Up', 3 }) },
  { key = 'l', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Right', 3 }) },

  -- Split panes: Alt+\ (vertical), Alt+- (horizontal)
  { key = '\\', mods = 'ALT', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = '-', mods = 'ALT', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },

  -- Close pane: Ctrl+q
  { key = 'q', mods = 'CTRL', action = act.CloseCurrentPane({ confirm = true }) },

  -- Toggle pane zoom: Ctrl+z
  { key = 'z', mods = 'CTRL', action = act.TogglePaneZoomState },

  -- Rotate panes: Alt+r (clockwise), Alt+Shift+r (counter-clockwise)
  { key = 'r', mods = 'ALT', action = act.RotatePanes('Clockwise') },
  { key = 'r', mods = 'ALT|SHIFT', action = act.RotatePanes('CounterClockwise') },

  -- Tab navigation: Ctrl+Tab / Ctrl+Shift+Tab
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },

  -- Tab navigation by number: Alt+1-9
  { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = act.ActivateTab(8) },

  -- New tab: Ctrl+t
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab('CurrentPaneDomain') },

  -- Close tab: Ctrl+w
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab({ confirm = true }) },
}

return config
