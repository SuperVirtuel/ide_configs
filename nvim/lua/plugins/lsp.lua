return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright", -- Python LSP
        "ruff", -- Python linter/formatter
      },
      automatic_installation = true,
    })

    -- Add LSP capabilities for autocomplete
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Custom root detection for your project structure
    local function find_python_root(fname)
      local util = require("lspconfig.util")
      
      -- First try standard markers including pyrightconfig.json
      local root = util.root_pattern("pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git")(fname)
      if root then
        return root
      end
      
      -- Fallback to DEV directory
      local dev_path = vim.fn.expand("~/DEV")
      if fname:match("^" .. vim.fn.escape(dev_path, "^$.*[]\\")) then
        return dev_path
      end
      
      return util.path.dirname(fname)
    end

    -- Python LSP (pyright) - new API
    vim.lsp.config.pyright = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    }
    vim.lsp.enable("pyright")
    
    -- Ruff (fast Python linter) - new API
    vim.lsp.config.ruff = {
      cmd = { "ruff", "server" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
      capabilities = capabilities,
    }
    vim.lsp.enable("ruff")
  end,
}
