return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-j>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
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
      require("CopilotChat").setup(opts)
    end,
  },
}
