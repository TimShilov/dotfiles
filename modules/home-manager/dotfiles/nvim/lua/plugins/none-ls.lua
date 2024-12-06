return {
  'nvimtools/none-ls.nvim',
  enabled = true,
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'davidmh/cspell.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local cspell = require 'cspell'
    local null_ls = require 'null-ls'

    require('mason-null-ls').setup {
      ensure_installed = {
        'cspell',
      },
      automatic_installation = true,
    }

    local sources = {
      cspell.diagnostics.with {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity['WARN']
        end,
      },
      cspell.code_actions,
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
  end,
}
