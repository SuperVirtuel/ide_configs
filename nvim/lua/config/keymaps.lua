-- Buffer navigation keymaps
vim.keymap.set("n", "<C-n>", "<cmd>enew<cr>", { desc = "New Buffer" })
vim.keymap.set("n", "<C-w>", function()
  local buf_count = #vim.fn.getbufinfo({buflisted = 1})
  if buf_count > 1 then
    vim.cmd("bp|bd! #")
  else
    vim.cmd("bd!")
  end
end, { desc = "Close Buffer" })
-- Removed <C-h> and <C-l> buffer navigation - now handled by smart-splits
-- Use <leader>h and <leader>l for buffer navigation instead
vim.keymap.set("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>de", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- Window split keymaps (matching WezTerm)
-- Note: Terminals can't reliably distinguish Ctrl+Shift+h from Ctrl+h
-- Using Alt+Shift instead which works in both WezTerm and Neovim
vim.keymap.set("n", "<A-S-h>", "<cmd>split<cr>", { desc = "Split Horizontal (Top/Bottom)" })
vim.keymap.set("n", "<A-S-v>", "<cmd>vsplit<cr>", { desc = "Split Vertical (Left/Right)" })

-- Close window/pane: Ctrl+Q (matching WezTerm)
vim.keymap.set("n", "<C-q>", "<cmd>close<cr>", { desc = "Close Window" })

-- Maximize/Zoom window: Ctrl+Z (matching WezTerm)
-- WezTerm handles pane zoom, this just toggles Neovim window zoom
vim.keymap.set("n", "<C-z>", function()
  if vim.t.maximized then
    vim.cmd("wincmd =")
    vim.t.maximized = false
  else
    vim.cmd("wincmd |")
    vim.cmd("wincmd _")
    vim.t.maximized = true
  end
end, { desc = "Toggle Window Zoom" })

-- Window resize keymaps
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })

-- Window navigation
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to Right Window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to Upper Window" })
