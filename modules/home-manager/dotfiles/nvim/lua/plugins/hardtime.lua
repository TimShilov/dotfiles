return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  events = { 'BufEnter' },
  opts = {
    disabled_keys = {
      ['<Up>'] = {},
      ['<Down>'] = {},
      ['<Left>'] = {},
      ['<Right>'] = {},
    },
    disable_mouse = false,
    restriction_mode = 'hint',
  },
}
