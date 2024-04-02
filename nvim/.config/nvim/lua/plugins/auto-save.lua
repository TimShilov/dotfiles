return {
  'okuuva/auto-save.nvim',
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { 'BufLeave', 'FocusLost', 'VimLeavePre' },
      defer_save = { 'InsertLeave' },
      cancel_defered_save = { 'InsertEnter' },
    },
    debounce_delay = 10000,
  },
}
