return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup({
      -- Ignored filetypes (only while resizing)
      ignored_filetypes = { "nofile", "quickfix", "prompt" },
      -- Ignored buffer types (only while resizing)
      ignored_buftypes = { "NvimTree" },
      -- the default number of lines/columns to resize by at a time
      default_amount = 3,
      -- whether to wrap to opposite side when cursor is at an edge
      at_edge = "wrap",
      -- Integration with WezTerm
      multiplexer_integration = "wezterm",
    })

    -- Set IS_NVIM variable for WezTerm integration
    vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
      group = vim.api.nvim_create_augroup("WezTermIntegration", { clear = true }),
      callback = function()
        io.stdout:write("\x1b]1337;SetUserVar=IS_NVIM=MQo\007")
      end,
    })
    vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
      group = vim.api.nvim_create_augroup("WezTermIntegrationLeave", { clear = true }),
      callback = function()
        io.stdout:write("\x1b]1337;SetUserVar=IS_NVIM\007")
      end,
    })

    -- Navigation keymaps (Ctrl + hjkl)
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

    -- Resizing keymaps (Alt + hjkl)
    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
  end,
}
