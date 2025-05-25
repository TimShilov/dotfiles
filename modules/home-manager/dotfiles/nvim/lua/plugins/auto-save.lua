local excluded_filetypes = {
  'gitcommit',
}
local excluded_filenames = {}

local function save_condition(buf)
  if vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf, '&filetype')) or vim.tbl_contains(excluded_filenames, vim.fn.expand '%:t') then
    return false
  end

  return true
end

return {
  'okuuva/auto-save.nvim',
  event = { 'InsertLeave', 'TextChanged' },
  opts = {
    enabled = true,
    condition = save_condition,
    trigger_events = {
      immediate_save = { 'BufLeave', 'FocusLost', 'VimLeavePre' },
      defer_save = { 'InsertLeave' },
      cancel_deferred_save = { 'InsertEnter' },
    },
    debounce_delay = 10000,
  },
}
