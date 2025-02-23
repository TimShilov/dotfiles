return {
  'johmsalas/text-case.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('textcase').setup {}
    require('telescope').load_extension 'textcase'
  end,
  keys = {
    { 'gai', '<cmd>TextCaseOpenTelescopeLSPChange<CR>', mode = { 'n', 'x' }, desc = 'Change case' },
  },
  cmd = {
    -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
    'Subs',
    'TextCaseOpenTelescope',
    'TextCaseOpenTelescopeQuickChange',
    'TextCaseOpenTelescopeLSPChange',
    'TextCaseStartReplacingCommand',
  },
  lazy = true,
}
