return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,

        ensure_installed = {
          'bash',
          'dockerfile',
          'go',
          'html',
          'javascript',
          'json',
          'lua',
          'terraform',
          'regex',
          'typescript',
          'yaml',
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<leader>k',
            node_incremental = '<leader>k',
            scope_incremental = '<c-s>',
            node_decremental = '<leader>j',
          },
        },
      }
      -- enable folding
      vim.cmd [[set foldmethod=expr]]
      vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
      vim.cmd [[set nofoldenable]]
    end, 0)
  end,
}
