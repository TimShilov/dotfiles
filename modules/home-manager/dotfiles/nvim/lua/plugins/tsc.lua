return {
  'dmmulroy/tsc.nvim',
  opts = {
    flags = {},
    auto_close_qflist = true,
  },
  keys = {
    {
      '<leader>rt',
      '<cmd>TSC<CR>',
      desc = 'Run TSC',
      mode = 'n',
    },
  },
}
