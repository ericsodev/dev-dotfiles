-- If using this, follow https://github.com/Davidyz/VectorCode/blob/main/docs/cli.md#installation to install vector code CLI
return {
  'Davidyz/VectorCode',
  version = '*', -- optional, depending on whether you're on nightly or release
  build = 'pipx upgrade vectorcode', -- optional but recommended. This keeps your CLI up-to-date.
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'VectorCode',
}
