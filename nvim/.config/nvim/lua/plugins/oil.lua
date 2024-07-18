return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
  },
  keys = {
    { '-', ':Oil<CR>', desc = 'Open parent directory' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
