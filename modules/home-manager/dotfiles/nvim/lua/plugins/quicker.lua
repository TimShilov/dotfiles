return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  keys = {
    {
      '<leader>q',
      function()
        require('quicker').toggle()
      end,
      desc = 'Toggle quickfix list',
    },
    {
      '<leader>l',
      function()
        require('quicker').toggle { loclist = true }
      end,
      desc = 'Toggle location list',
    },
  },
}
