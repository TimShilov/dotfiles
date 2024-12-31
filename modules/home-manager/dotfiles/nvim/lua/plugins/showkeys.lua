return {
  'nvzone/showkeys',
  cmd = 'ShowkeysToggle',
  lazy = true,
  opts = {
    maxkeys = 5,
    winopts = {
      border = 'rounded',
    },
    position = 'top-right',
  },
  keys = {
    { '<leader>tk', '<cmd>ShowkeysToggle<CR>', desc = 'Show keys', mode = { 'n' } },
  },
}
