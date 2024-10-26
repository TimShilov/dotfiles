return {
  {
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
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              -- You can also use captures from other query groups like `locals.scm`
              ['as'] = { query = '@local.scope', query_group = 'locals', desc = 'Select language scope' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            -- selection_modes = {
            --   ['@parameter.outer'] = 'v', -- charwise
            --   ['@function.outer'] = 'V', -- linewise
            --   ['@class.outer'] = '<c-v>', -- blockwise
            -- },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next = {
              [']d'] = '@conditional.outer',
            },
            goto_previous = {
              ['[d'] = '@conditional.outer',
            },
          },
          lsp_interop = {
            enable = true,
            border = 'rounded',
            floating_preview_opts = {},
            peek_definition_code = {
              ['<leader>cd'] = '@function.outer',
              ['<leader>cD'] = '@class.outer',
            },
          },
        },
      }
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context', dependencies = { 'nvim-treesitter' } },
}
