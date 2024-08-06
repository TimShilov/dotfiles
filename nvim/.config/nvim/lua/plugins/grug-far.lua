return {
  'MagicDuck/grug-far.nvim',
  opts = {
    -- disable automatic debounced search and trigger search when leaving insert mode instead
    searchOnInsertLeave = false,

    -- specifies the command to run (with `vim.cmd(...)`) in order to create
    -- the window in which the grug-far buffer will appear
    -- ex (horizontal bottom right split): 'botright split'
    -- ex (open new tab): 'tabnew %'
    windowCreationCommand = 'tabnew %',

    -- whether or not to make a transient buffer which is both unlisted and fully deletes itself when not in use
    transient = false,
  },
  -- config = function()
  --   require('grug-far').setup {}
  -- end,
}
