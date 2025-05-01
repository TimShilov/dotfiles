return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          gitsigns.nav_hunk('next', { target = 'all' })
        end, { desc = 'Next hunk' })

        map('n', '[c', function()
          gitsigns.nav_hunk('prev', { target = 'all' })
        end, { desc = 'Previous hunk' })

        -- Actions
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, { desc = 'Blame line' })
        map('n', '<leader>gb', gitsigns.blame, { desc = 'Git Blame' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff this' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '~'
        end, { desc = 'Diff this' })
        map('n', '<leader>td', gitsigns.preview_hunk_inline, { desc = 'Toggle deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
      end,
    },
  },
  {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    opts = {},
    keys = {
      { '<leader>gy', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank git link' },
      { '<leader>gY', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link' },
    },
  },
}
