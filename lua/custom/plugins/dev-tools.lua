return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-`>', '<cmd>ToggleTerm<cr>', mode = { 'n', 'i', 't' }, desc = 'VS Code: Toggle Terminal' },
      { '<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Toggle [T]erminal' },
    },
    opts = {
      direction = 'float',
      start_in_insert = true,
    },
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- See `:help lazygit.txt` for more custom configuration
  },
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'VS Code: Start/Continue Debugging' },
      { '<S-F5>', function() require('dap').terminate() end, desc = 'VS Code: Stop Debugging' },
      { '<F9>', function() require('dap').toggle_breakpoint() end, desc = 'VS Code: Toggle Breakpoint' },
      { '<F10>', function() require('dap').step_over() end, desc = 'VS Code: Step Over' },
      { '<F11>', function() require('dap').step_into() end, desc = 'VS Code: Step Into' },
      { '<S-F11>', function() require('dap').step_out() end, desc = 'VS Code: Step Out' },
    },
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        config = function()
          local dap, dapui = require 'dap', require 'dapui'
          dapui.setup()
          dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
          dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
          dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
        end,
      },
      {
        'mxsdev/nvim-dap-vscode-js',
        dependencies = { 'mfussenegger/nvim-dap' },
        opts = {
          debugger_path = vim.fn.stdpath 'data' .. '/lazy/nvim-dap-vscode-js',
          adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
        },
      },
    },
  },
  {
    'ekalinin/dockerfile.vim',
    ft = 'dockerfile',
  },
}
