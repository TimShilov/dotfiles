return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      keyword = 'fg',
    },
  },
  config = function(_, opts)
    local todo = require 'todo-comments'
    todo.setup(opts)

    vim.keymap.set('n', ']t', function()
      todo.jump_next()
    end, { desc = 'Next todo comment' })

    vim.keymap.set('n', '[t', function()
      todo.jump_prev()
    end, { desc = 'Previous todo comment' })
  end,
}
