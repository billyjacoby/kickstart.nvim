return {
  { 'folke/tokyonight.nvim', enabled = false },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      italic_comments = false,
      hide_fillchars = true,
      borderless_telescope = false,
    },
    config = function(_, opts)
      require('cyberdream').setup(opts)
      vim.cmd.colorscheme 'cyberdream'
    end,
  },
}
