return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local dropbar = require 'dropbar'
    local dropbar_api = require 'dropbar.api'

    local sources = require 'dropbar.sources'

    dropbar.setup {
      bar = { sources = { sources.path } },
      menu = { preview = false },
    }

    vim.keymap.set('n', '<leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  end,
}
