local theme = require 'lualine.themes.catppuccin'
theme.normal.c.bg = nil
local function get_timerly_status()
  local state = require 'timerly.state'
  if state.progress == 0 then
    return ''
  end

  local total = math.max(0, state.total_secs + 1) -- Add 1 to sync with timer display
  local mins = math.floor(total / 60)
  local secs = total % 60

  return string.format('%s %02d:%02d', state.mode:gsub('^%l', string.upper), mins, secs)
end

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = theme,
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_b = { 'branch', 'diagnostics' },
      lualine_c = { '%=' },
      lualine_x = { 'filetype', get_timerly_status },
    },
  },
}
