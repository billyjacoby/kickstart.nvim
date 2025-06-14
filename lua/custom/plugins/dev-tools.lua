return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { [[<c-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { '<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Toggle [T]erminal' },
    },
    opts = {
      direction = "float",
      start_in_insert = true,
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- See `:help lazygit.txt` for more custom configuration
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {"mfussenegger/nvim-dap"},
        opts = {
          debugger_path = vim.fn.stdpath("data") .. "/lazy/nvim-dap-vscode-js",
          adapters = {'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost'}
        }
      },
    },
  },
  {
    "ekalinin/dockerfile.vim",
    ft = "dockerfile",
  },
} 