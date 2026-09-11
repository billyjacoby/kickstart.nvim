local M = {}

local function telescope(picker, options)
  return function() require('telescope.builtin')[picker](options or {}) end
end

function M.setup()
  local map = vim.keymap.set

  -- Files, search, and the command palette.
  map({ 'n', 'i' }, '<C-p>', telescope 'find_files', { desc = 'VS Code: Quick Open' })
  map({ 'n', 'i' }, '<C-S-p>', telescope 'commands', { desc = 'VS Code: Command Palette' })
  map({ 'n', 'i' }, '<C-S-f>', telescope 'live_grep', { desc = 'VS Code: Search Project' })
  map('n', '<C-f>', telescope('current_buffer_fuzzy_find', { previewer = false }), { desc = 'VS Code: Find in File' })
  map('n', '<C-S-o>', telescope 'lsp_document_symbols', { desc = 'VS Code: Go to Symbol' })
  map('n', '<C-,>', function() vim.cmd.edit(vim.fs.joinpath(vim.fn.stdpath 'config', 'init.lua')) end, { desc = 'VS Code: Open Settings' })

  -- Files and editor tabs (Neovim buffers).
  map({ 'n', 'i', 'x' }, '<C-s>', '<cmd>update<cr>', { desc = 'VS Code: Save File', silent = true })
  map({ 'n', 'i' }, '<C-n>', '<cmd>enew<cr>', { desc = 'VS Code: New File', silent = true })
  map({ 'n', 'i' }, '<C-w>', '<cmd>bdelete<cr>', { desc = 'VS Code: Close Editor', silent = true })
  map({ 'n', 'i' }, '<C-Tab>', '<cmd>bnext<cr>', { desc = 'VS Code: Next Editor', silent = true })
  map({ 'n', 'i' }, '<C-S-Tab>', '<cmd>bprevious<cr>', { desc = 'VS Code: Previous Editor', silent = true })
  map({ 'n', 'i' }, '<C-z>', '<cmd>undo<cr>', { desc = 'VS Code: Undo', silent = true })
  map({ 'n', 'i' }, '<C-S-z>', '<cmd>redo<cr>', { desc = 'VS Code: Redo', silent = true })

  -- Editing and language features.
  map('n', '<F2>', vim.lsp.buf.rename, { desc = 'VS Code: Rename Symbol' })
  map('n', '<F12>', vim.lsp.buf.definition, { desc = 'VS Code: Go to Definition' })
  map('n', '<S-F12>', vim.lsp.buf.references, { desc = 'VS Code: Find References' })
  map({ 'n', 'x' }, '<C-.>', vim.lsp.buf.code_action, { desc = 'VS Code: Quick Fix' })
  map({ 'n', 'x' }, '<A-S-f>', function() vim.lsp.buf.format { async = true } end, { desc = 'VS Code: Format Document' })

  map('n', '<C-/>', 'gcc', { desc = 'VS Code: Toggle Line Comment', remap = true })
  map('x', '<C-/>', 'gc', { desc = 'VS Code: Toggle Selection Comment', remap = true })
  map('n', '<C-_>', 'gcc', { desc = 'VS Code: Toggle Line Comment', remap = true })
  map('x', '<C-_>', 'gc', { desc = 'VS Code: Toggle Selection Comment', remap = true })

  map('n', '<A-Down>', '<cmd>move .+1<cr>==', { desc = 'VS Code: Move Line Down', silent = true })
  map('n', '<A-Up>', '<cmd>move .-2<cr>==', { desc = 'VS Code: Move Line Up', silent = true })
  map('i', '<A-Down>', '<Esc><cmd>move .+1<cr>==gi', { desc = 'VS Code: Move Line Down', silent = true })
  map('i', '<A-Up>', '<Esc><cmd>move .-2<cr>==gi', { desc = 'VS Code: Move Line Up', silent = true })
  map('x', '<A-Down>', ":move '>+1<cr>gv=gv", { desc = 'VS Code: Move Selection Down', silent = true })
  map('x', '<A-Up>', ":move '<-2<cr>gv=gv", { desc = 'VS Code: Move Selection Up', silent = true })

  -- Ctrl+W now closes an editor like VS Code. These preserve easy split control.
  map('n', '<C-\\>', '<cmd>vsplit<cr>', { desc = 'VS Code: Split Editor', silent = true })
  map('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = '[W]indow: Split [V]ertically', silent = true })
  map('n', '<leader>ws', '<cmd>split<cr>', { desc = '[W]indow: [S]plit Horizontally', silent = true })
  map('n', '<leader>wq', '<cmd>close<cr>', { desc = '[W]indow: [Q]uit Split', silent = true })
  map('n', '<leader>wh', '<C-w>h', { desc = '[W]indow: Move Left' })
  map('n', '<leader>wj', '<C-w>j', { desc = '[W]indow: Move Down' })
  map('n', '<leader>wk', '<C-w>k', { desc = '[W]indow: Move Up' })
  map('n', '<leader>wl', '<C-w>l', { desc = '[W]indow: Move Right' })
end

return M
