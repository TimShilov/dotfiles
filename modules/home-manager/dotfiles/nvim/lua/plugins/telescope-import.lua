return {
  'piersolenski/telescope-import.nvim',
  dependencies = 'nvim-telescope/telescope.nvim',
  event = { 'BufReadPost' },
  config = function()
    require('telescope').load_extension 'import'
  end,
  keys = { { '<leader>ai', ':Telescope import<CR>', mode = 'n', desc = 'Add Import' } },
}
