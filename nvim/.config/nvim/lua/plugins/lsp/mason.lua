return {
  'mason-org/mason.nvim',
  dependencies = { 'mason-org/mason-lspconfig.nvim', 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  opts = {},
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()
    require('mason-tool-installer').setup {
      ensure_installed = {
        'lua_ls',
        'stylua',
      },
    }
  end,
}
