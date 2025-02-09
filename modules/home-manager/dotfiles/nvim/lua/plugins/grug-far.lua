return {
  'MagicDuck/grug-far.nvim',
  opts = {
    -- disable automatic debounced search and trigger search when leaving insert mode instead
    searchOnInsertLeave = false,

    -- whether or not to make a transient buffer which is both unlisted and fully deletes itself when not in use
    transient = true,
    engines = {
      astgrep = {
        path = 'ast-grep',
      },
    },

    history = {
      autoSave = { enabled = true },
    },
  },
  keys = {
    { '<leader>ss', '<cmd>GrugFar<CR>', desc = 'GrugFar: Search' },
  },
}
