return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    popupmenu = {
      backend = 'cmp',
    },
    views = {
      mini = {
        win_options = {
          winblend = 0,
        },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'hrsh7th/nvim-cmp',
  },
}
