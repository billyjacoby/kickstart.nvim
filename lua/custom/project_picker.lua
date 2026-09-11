local M = {}

local projects_root = vim.fs.normalize(vim.fn.expand '~/Programming')

function M.projects()
  local projects = {
    { name = 'Programming (root)', path = projects_root },
  }

  if vim.fn.isdirectory(projects_root) ~= 1 then return projects end

  for name, kind in vim.fs.dir(projects_root) do
    if kind == 'directory' and not vim.startswith(name, '.') then table.insert(projects, { name = name, path = vim.fs.joinpath(projects_root, name) }) end
  end

  table.sort(projects, function(a, b)
    if a.path == projects_root then return true end
    if b.path == projects_root then return false end
    return a.name:lower() < b.name:lower()
  end)

  return projects
end

function M.open()
  if vim.fn.isdirectory(projects_root) ~= 1 then
    vim.notify(('Project directory does not exist: %s'):format(projects_root), vim.log.levels.ERROR)
    return
  end

  vim.cmd.cd(vim.fn.fnameescape(projects_root))

  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local finders = require 'telescope.finders'
  local pickers = require 'telescope.pickers'
  local config = require('telescope.config').values

  pickers
    .new({}, {
      prompt_title = 'Open project from ~/Programming',
      finder = finders.new_table {
        results = M.projects(),
        entry_maker = function(project)
          return {
            value = project,
            display = project.name,
            ordinal = project.name,
            path = project.path,
          }
        end,
      },
      sorter = config.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if not selection then return end

          vim.cmd.cd(vim.fn.fnameescape(selection.path))
          require('telescope.builtin').find_files {
            cwd = selection.path,
            hidden = true,
            prompt_title = ('Files in %s'):format(selection.value.name),
          }
        end)
        return true
      end,
    })
    :find()
end

function M.setup()
  vim.keymap.set('n', '<leader>sp', M.open, { desc = '[S]earch [P]rojects' })

  vim.api.nvim_create_autocmd('VimEnter', {
    desc = 'Open the Programming project picker when Neovim starts without a target',
    callback = function()
      if vim.fn.argc() ~= 0 or vim.tbl_contains(vim.v.argv, '-') then return end

      local current_buffer = vim.api.nvim_get_current_buf()
      if vim.bo[current_buffer].buftype ~= '' or vim.api.nvim_buf_get_name(current_buffer) ~= '' then return end

      vim.cmd.cd(vim.fn.fnameescape(projects_root))
      if #vim.api.nvim_list_uis() == 0 then return end

      vim.schedule(M.open)
    end,
  })
end

return M
