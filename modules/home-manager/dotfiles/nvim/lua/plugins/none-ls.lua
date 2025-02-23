return {
  'nvimtools/none-ls.nvim',
  enabled = true,
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'davidmh/cspell.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local cspell = require 'cspell'
    local null_ls = require 'null-ls'

    require('mason-null-ls').setup {
      ensure_installed = {
        'cspell',
      },
      automatic_installation = true,
    }

    local project_root = { vim.fs.dirname(vim.fs.find({ '.git', 'cspell.json' }, { upward = true })[1]), '~/.config/' }
    local cspell_options = {
      cspell_config_dirs = { project_root, '~/.config/' },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity['WARN']
      end,
    }

    local sources = {
      cspell.diagnostics.with(cspell_options),
      cspell.code_actions.with(cspell_options),
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
