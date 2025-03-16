---@module "snacks"
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = false },
    input = { enabled = false },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ['<C-o>'] = { 'oil', mode = { 'n', 'i' } },
          },
        },
      },
      actions = {
        oil = function(picker)
          local oil = require 'oil'

          local dir_name = vim.fs.dirname(picker.list._current.file)
          picker:close()
          oil.close {}

          oil.open(dir_name, {}, function() end)
        end,
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = {
      enabled = false,
    },
    scroll = {
      enabled = false,
    },
    statuscolumn = { enabled = true, patterns = { 'GitSign', 'MiniDiffSign' } },
    words = { enabled = true },
  },
  keys = {
    -- Search
    { '<leader>sf', function() Snacks.picker.files() end },
    { '<leader>sg', function() Snacks.picker.grep() end },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
    { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },
    { '<leader>sc', function() Snacks.picker.colorschemes() end, desc = '[S]earch [C]olour' },
    -- LSP
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
    -- Git
    { '<leader>lg', function() Snacks.lazygit() end, desc = '[L]azy[G]it' },
    -- Other
    { '<leader>tt', function() Snacks.terminal() end, desc = '[T]oggle [T]erminal' },
    { '<leader>te', function() Snacks.explorer() end, desc = '[T]oggle [E]xplorer' },
    { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
  },
}
