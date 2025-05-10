return {
  {
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        autosave_changes = true,
      },
      watch_for_changes = true,
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<C-p>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
        ['gs'] = 'actions.change_sort',
        -- ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      { '-', ':Oil<CR>', desc = 'Open parent directory' },
    },
  },
}
