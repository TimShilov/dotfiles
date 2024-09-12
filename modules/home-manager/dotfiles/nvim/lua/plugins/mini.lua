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
    opts = {
      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of 'open', 'close', 'closeopen'.
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      mappings = {
        -- Prevents the action if the cursor is just before any character or next to a "\".
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][%s%)%]%}]' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][%s%)%]%}]' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][%s%)%]%}]' },
        -- This is default (prevents the action if the cursor is just next to a "\").
        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
        -- Prevents the action if the cursor is just before or next to any character.
        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%w][^%w]', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%w][^%w]', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%w][^%w]', register = { cr = false } },
      },
    },
  },
}
