return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'j-hui/fidget.nvim',
  },
  config = function()
    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'copilot',
        },
        inline = {
          adapter = 'copilot',
        },
      },
      adapters = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'claude-3.7-sonnet',
              },
            },
          })
        end,
      },
    }

    -- Keymaps
    vim.keymap.set('n', '<leader>tc', ':CodeCompanionChat Toggle<enter>', { desc = '[T]oggle [C]hat' })
    vim.keymap.set('n', '<leader>cca', ':CodeCompanionActions<enter>', { desc = '[C]ode [C]ompanion [A]ctions' })
    vim.keymap.set('x', '<leader>ccp', ':CodeCompanion<enter>', { desc = '[C]ode [C]ompanion [P]rompt' })

    -- Events
    local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'CodeCompanionInline*',
      group = group,
      callback = function(request)
        if request.match == 'CodeCompanionInlineFinished' then
          -- Format the buffer after the inline request has completed
          require('conform').format { bufnr = request.buf }
        end
      end,
    })
  end,
  init = function() require('plugins.code-companion.fidget-spinner'):init() end,
}
