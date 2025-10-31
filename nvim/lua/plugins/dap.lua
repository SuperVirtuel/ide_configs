return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dt", function() require("dapui").toggle() end, desc = "Toggle UI" },
    { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    
    -- Setup DAP UI
    dapui.setup()
    
    -- Setup Python debugger - use python3 executable
    require("dap-python").setup("python3")
    
    -- Disable automatic loading of launch.json
    require("dap.ext.vscode").json_decode = function(str)
      return {}
    end
    
    -- Auto open UI when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    
    -- Keep UI open after debugging ends (comment out auto-close)
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    -- end
  end,
}
