return {
  'gaelph/logsitter.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    {
      '<leader>la',
      function()
        require('logsitter').log()
      end,
      desc = 'Log word under cursor',
      mode = 'n',
    },
    {
      '<leader>la',
      function()
        require('logsitter').log_visual()
      end,
      desc = 'Log selection',
      mode = 'x',
    },
    {
      '<leader>lc',
      '<cmd>LogsitterClearBuf<CR>',
      desc = 'Clear all logs',
      mode = 'n',
    },
  },
}
