return {
  'vuki656/package-info.nvim',
  -- Disabled because it conflicts with Octo.nvim PR review
  -- TODO: Figure out how to fix it
  enabled = false,
  dependencies = { 'MunifTanjim/nui.nvim' },
  event = 'BufEnter package.json',
  ft = 'json',
  config = function()
    require('package-info').setup {
      hide_up_to_date = true,
      hide_unstable_versions = true,
    }

    require('telescope').load_extension 'package_info'
  end,
}
