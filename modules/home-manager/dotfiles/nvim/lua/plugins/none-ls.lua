return {
  'nvimtools/none-ls.nvim',
  enabled = false,
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting

    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'shfmt',
      },
      automatic_installation = true,
    }

    local sources = {
      formatting.prettier.with {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'css',
          'scss',
          'less',
          'html',
          'json',
          'json5',
          'jsonc',
          'yaml',
          'markdown',
          'markdown.mdx',
          'graphql',
          'handlebars',
          'svelte',
          'astro',
          'htmlangular',
        },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.sql_formatter.with { command = { 'sleek' } },
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }

    vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { noremap = true, desc = 'Format buffer' })
  end,
}
