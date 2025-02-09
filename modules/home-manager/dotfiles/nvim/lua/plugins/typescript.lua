return {
  'pmizio/typescript-tools.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('typescript-tools').setup {
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      complete_function_calls = true,
      expose_as_code_action = 'all',
      code_lens = 'all',
    }

    local typescript_on_save_augroup = vim.api.nvim_create_augroup('FormatOnSave', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.ts',
      group = typescript_on_save_augroup,
      callback = function(event)
        vim.cmd 'silent! TSToolsRemoveUnusedImports sync'
        vim.cmd 'silent! TSToolsAddMissingImports sync'
      end,
    })
  end,
}
