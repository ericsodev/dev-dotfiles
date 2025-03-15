return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  --
  config = function()
    -- Declare a global function to retrieve the current directory
    function _G.get_oil_winbar()
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = require('oil').get_current_dir(bufnr)
      if dir then
        return vim.fn.fnamemodify(dir, ':~')
      else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
      end
    end

    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['q'] = { 'actions.close', mode = 'n' },
        ['<BS>'] = { 'actions.parent', mode = 'n' },
      },
      watch_for_changes = true,
      win_options = {
        winbar = '%!v:lua.get_oil_winbar()',
      },
    }

    -- Auto enable preview on select
    vim.api.nvim_create_autocmd('User', {
      pattern = 'OilEnter',
      callback = vim.schedule_wrap(function(args)
        local oil = require 'oil'
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.open_preview()
        end
      end),
    })

    vim.keymap.set('n', '_', require('oil').open)
  end,
}
