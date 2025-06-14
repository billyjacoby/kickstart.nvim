-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<C-b>', ':Neotree filesystem toggle left<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- This is what you want: If you set this to `true`, all "hidden" files will be shown
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<C-b>'] = 'close_window',
        },
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Open Neo-tree if no files or only a directory is passed",
      group = vim.api.nvim_create_augroup("kickstart-neotree-open", { clear = true }),
      callback = function()
        local arg_count = vim.fn.argc()
        if arg_count == 0 then
          -- No files passed, open Neo-tree
          vim.cmd("Neotree filesystem left")
        elseif arg_count == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
          -- A single directory was passed, open Neo-tree
          vim.cmd("Neotree filesystem left")
        end
      end,
    })
  end,
}
