local wezterm = require 'wezterm'
local config = {}

config.default_prog = { '/usr/bin/fish' }
config.color_scheme = 'moonfly'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 12.0
config.window_background_opacity = 0.95

-- Disable default key assignments to avoid conflicts
config.disable_default_key_bindings = false

-- Helper function to check if neovim is running in the current pane
local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == 'true'
end

-- Smart navigation that integrates with nvim smart-splits
local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

config.keys = {
  -- Navigation: Ctrl+hjkl
  {
    key = 'h',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'h', mods = 'CTRL' }), pane)
      else
        window:perform_action(wezterm.action.ActivatePaneDirection('Left'), pane)
      end
    end),
  },
  {
    key = 'j',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'j', mods = 'CTRL' }), pane)
      else
        window:perform_action(wezterm.action.ActivatePaneDirection('Down'), pane)
      end
    end),
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'k', mods = 'CTRL' }), pane)
      else
        window:perform_action(wezterm.action.ActivatePaneDirection('Up'), pane)
      end
    end),
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'l', mods = 'CTRL' }), pane)
      else
        window:perform_action(wezterm.action.ActivatePaneDirection('Right'), pane)
      end
    end),
  },

  -- Resizing: Alt+hjkl
  {
    key = 'h',
    mods = 'ALT',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'h', mods = 'ALT' }), pane)
      else
        window:perform_action(wezterm.action.AdjustPaneSize({ 'Left', 3 }), pane)
      end
    end),
  },
  {
    key = 'j',
    mods = 'ALT',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'j', mods = 'ALT' }), pane)
      else
        window:perform_action(wezterm.action.AdjustPaneSize({ 'Down', 3 }), pane)
      end
    end),
  },
  {
    key = 'k',
    mods = 'ALT',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'k', mods = 'ALT' }), pane)
      else
        window:perform_action(wezterm.action.AdjustPaneSize({ 'Up', 3 }), pane)
      end
    end),
  },
  {
    key = 'l',
    mods = 'ALT',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'l', mods = 'ALT' }), pane)
      else
        window:perform_action(wezterm.action.AdjustPaneSize({ 'Right', 3 }), pane)
      end
    end),
  },

  -- Splitting: Alt+Shift+H/V
  -- H = Horizontal split (top/bottom), V = Vertical split (left/right)
  {
    key = 'H',
    mods = 'ALT|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'H', mods = 'ALT|SHIFT' }), pane)
      else
        window:perform_action(wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }), pane)
      end
    end),
  },
  {
    key = 'V',
    mods = 'ALT|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'V', mods = 'ALT|SHIFT' }), pane)
      else
        window:perform_action(wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }), pane)
      end
    end),
  },

  -- Close pane: Ctrl+Q
  {
    key = 'q',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'q', mods = 'CTRL' }), pane)
      else
        window:perform_action(wezterm.action.CloseCurrentPane({ confirm = true }), pane)
      end
    end),
  },

  -- Maximize/Zoom pane: Ctrl+Z
  -- When in Neovim, toggle both WezTerm pane AND send key to Neovim
  {
    key = 'z',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      -- Always toggle WezTerm pane zoom
      window:perform_action(wezterm.action.TogglePaneZoomState, pane)
      -- If in Neovim, also send the key so Neovim can toggle its window zoom
      if is_vim(pane) then
        window:perform_action(wezterm.action.SendKey({ key = 'z', mods = 'CTRL' }), pane)
      end
    end),
  },
}

return config
