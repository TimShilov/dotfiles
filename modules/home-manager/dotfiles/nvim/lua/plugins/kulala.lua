vim.filetype.add {
  extension = {
    ['http'] = 'http',
  },
}

return {
  'mistweaverco/kulala.nvim',
  ft = 'http',
  opts = {
    split_direction = 'horizontal',
  },
}
