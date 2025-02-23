return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    menu = {
      preview = false,
    },
  },
  config = function(_, opts)
    local dropbar = require 'dropbar'
    local dropbar_api = require 'dropbar.api'

    dropbar.setup(opts)

    vim.keymap.set('n', '<leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  end,
}
