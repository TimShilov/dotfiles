return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = 'catppuccin',
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_b = { 'branch', 'diagnostics' },
      lualine_c = { '%=', { 'filename', filestatus = true, path = 1 } },
      lualine_x = { 'filetype' },
    },
  },
}
