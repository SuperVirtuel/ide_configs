return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- can be "hard", "soft" or empty string
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end,
}
