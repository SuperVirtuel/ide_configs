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
vim.keymap.set("n", "<C-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>de", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- Window split keymaps
vim.keymap.set("n", "<C-s>h", function()
  vim.cmd("split")
  vim.cmd("enew")
end, { desc = "Split Horizontal" })
vim.keymap.set("n", "<C-s>v", function()
  vim.cmd("vsplit")
  vim.cmd("enew")
end, { desc = "Split Vertical" })

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
