local function nvim_tree_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc) return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  local function change_root_to_node(node)
    if node == nil then
      node = api.tree.get_node_under_cursor()
    end

    if node ~= nil and node.type == 'directory' then
      vim.api.nvim_set_current_dir(node.absolute_path)
    end
    api.tree.change_root_to_node(node)
  end

  local function change_root_to_parent(node)
    local abs_path
    if node == nil then
      abs_path = api.tree.get_nodes().absolute_path
    else
      abs_path = node.absolute_path
    end

    local parent_path = vim.fs.dirname(abs_path)
    vim.api.nvim_set_current_dir(parent_path)
    api.tree.change_root(parent_path)
  end

  vim.keymap.set('n', '<C-]>', change_root_to_node, opts 'CD')
  vim.keymap.set('n', '<2-RightMouse>', change_root_to_node, opts 'CD')
  vim.keymap.set('n', '-', change_root_to_parent, opts 'Up')
end
return {
  'https://github.com/nvim-tree/nvim-tree.lua',
  dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup { on_attach = nvim_tree_on_attach }

    vim.keymap.set('n', '<leader>te', '<cmd>NvimTreeToggle<cr>', { desc = '[T]oggle [E]xplorer' })

    ----- REMEMBER WINDOW SIZE
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#remember-nvimtree-window-size
    local api = require 'nvim-tree.api'
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd

    -- save nvim-tree window width on WinResized event
    augroup('save_nvim_tree_width', { clear = true })
    autocmd('WinResized', {
      group = 'save_nvim_tree_width',
      pattern = '*',
      callback = function()
        local winid = api.tree.winid()
        if winid ~= nil and vim.tbl_contains(vim.v.event['windows'], winid) then
          vim.t['filetree_width'] = vim.api.nvim_win_get_width(winid)
        end
      end,
    })
    -- restore window size when openning nvim-tree
    api.events.subscribe(api.events.Event.TreeOpen, function()
      if vim.t['filetree_width'] ~= nil then
        local winid = api.tree.winid()
        vim.api.nvim_win_set_width(winid, vim.t['filetree_width'])
      end
    end)

    -- Focus file in nvim-tree with <leader>e
    vim.keymap.set('n', '<leader>tp', function() api.tree.find_file { open = true, focus = true, desc = 'Expand file in tree' } end)
  end,
  ----- REMEMBER WINDOW SIZE
}
