return {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.startify")
  
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
  
      alpha.setup(dashboard.opts)

      vim.api.nvim_create_autocmd('VimEnter', {
        pattern = '*',
        nested = true,
        callback = function()
          local bufs = vim.api.nvim_list_bufs()
          local is_real_buf_present = false
          for _, buf in ipairs(bufs) do
            if vim.bo[buf].buftype == '' then
              is_real_buf_present = true
              break
            end
          end

          if not is_real_buf_present then
            require('alpha').start(true)
            vim.cmd('wincmd p')
          end
        end,
      })
    end,
  }