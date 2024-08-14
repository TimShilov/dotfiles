return {
  'rmagatti/auto-session',
  -- Temporary disabled to investigate if causing issues
  enabled = false,
  config = function()
    require('auto-session').setup {
      auto_session_suppress_dirs = { '~/', '~/Downloads', '~/Desktop' },
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = true,
      },
    }
  end,
}
