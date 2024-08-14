return {
  'gabrielpoca/replacer.nvim',
  opts = { rename_files = false },
  keys = {
    {
      '<leader>tr',
      function()
        local replacer = require 'replacer'

        replacer.run()
      end,
      desc = 'run replacer.nvim',
    },
  },
}
