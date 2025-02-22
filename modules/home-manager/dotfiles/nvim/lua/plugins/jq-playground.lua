return {
  'yochem/jq-playground.nvim',
  opts = {
    cmd = { 'jq' },
    query_window = {
      height = 0.2,
    },
  },
  keys = { { '<leader>jq', '<cmd>JqPlayground<CR>', desc = 'jq playground', mode = 'n' } },
}
