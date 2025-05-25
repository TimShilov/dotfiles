return {
  {
    'echasnovski/mini.move',
    version = false,
    opts = {
      mappings = {
        -- Move visual selection in Visual mode.
        down = '<S-Down>',
        up = '<S-Up>',

        -- Move current line in Normal mode
        line_down = '<S-Down>',
        line_up = '<S-Up>',
      },
    },
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
    'echasnovski/mini.operators',
    version = false,
    opts = {
      exchange = {
        -- 'gx' by default but it conflicts with built-in 'gx' mapping.
        prefix = '',
      },
      replace = {
        -- 'gr' by default but it conflicts with built-in 'gr' mappings.
        prefix = 'gp',
      },
    },
  },
  {
    'echasnovski/mini.icons',
    version = false,
    opts = {},
  },
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {},
  },
  {
    'echasnovski/mini.snippets',
    version = false,
    opts = {},
  },
}
