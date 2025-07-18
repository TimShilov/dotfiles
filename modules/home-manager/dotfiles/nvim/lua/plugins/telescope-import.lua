return {
  'piersolenski/import.nvim',
  dependencies = { 'folke/snacks.nvim' },
  event = { 'BufReadPost' },
  opts = {
    picker = 'snacks',
  },
  keys = { {
    '<leader>ai',
    function()
      require('import').pick()
    end,
    mode = 'n',
    desc = 'Add Import',
  } },
}
