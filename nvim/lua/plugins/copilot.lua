return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    debug = false,
    window = {
      layout = 'vertical',
      width = 0.4,
    },
  },
  keys = {
    { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
    { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code", mode = {"n", "v"} },
    { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests", mode = {"n", "v"} },
    { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fix Code", mode = {"n", "v"} },
    { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Code", mode = {"n", "v"} },
    { "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = "Generate Docs", mode = {"n", "v"} },
  },
  config = function(_, opts)
    -- Accept suggestion with Ctrl+J
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    
    -- Setup CopilotChat
    require("CopilotChat").setup(opts)
  end,
}
