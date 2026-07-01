return {
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        ['html'] = {
          enable_close = false,
        },
      },
    }

    -- Update LSP diagnostics after tag name update
    vim.lsp.handlers['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
      config = config or {}
      config.underline = true
      config.virtual_text = {
        spacing = 5,
        severity = { min = vim.diagnostic.severity.WARN },
      }
      config.update_in_insert = true

      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end
  end,
}
