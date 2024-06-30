return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { '-', ':Oil<CR>', desc = 'Open parent directory' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
