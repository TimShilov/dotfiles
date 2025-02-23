return {
  'okuuva/auto-save.nvim',
  event = { 'InsertLeave', 'TextChanged' },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { 'BufLeave', 'FocusLost', 'VimLeavePre' },
      defer_save = { 'InsertLeave' },
      cancel_deferred_save = { 'InsertEnter' },
    },
    debounce_delay = 10000,
  },
}
