return {
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require('mini.surround').setup()
    end,
  },
  {
    'echasnovski/mini.ai',
    version = false,
  },
  {
    'echasnovski/mini.bracketed',
    version = false,
    config = function()
      local MiniBracketed = require 'mini.bracketed'
      MiniBracketed.setup()

      local severity_error = vim.diagnostic.severity.ERROR
      vim.keymap.set({ 'n', 'v' }, ']e', function()
        MiniBracketed.diagnostic('forward', { severity = severity_error })
      end, { desc = 'Next Error' })
      vim.keymap.set({ 'n', 'v' }, '[e', function()
        MiniBracketed.diagnostic('backward', { severity = severity_error })
      end, { desc = 'Previous Error' })
    end,
  },
  {
    'echasnovski/mini.comment',
    version = false,
  },
  {
    'echasnovski/mini.operators',
    version = false,
    config = function()
      require('mini.operators').setup()
    end,
  },
  {
    'echasnovski/mini.icons',
    version = false,
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function()
      require('mini.pairs').setup()
    end,
  },
}
