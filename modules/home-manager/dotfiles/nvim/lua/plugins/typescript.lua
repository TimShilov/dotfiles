local typescript_on_save_augroup = vim.api.nvim_create_augroup('FormatOnSave', {})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.ts,*.js,*.cjs,*.mjs',
    group = typescript_on_save_augroup,
    buffer = bufnr,
    callback = function(event)
        vim.cmd 'TSToolsRemoveUnusedImports sync'
        vim.cmd 'TSToolsAddMissingImports sync'
    end,
})

return {
    'pmizio/typescript-tools.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
        { 'dmmulroy/ts-error-translator.nvim', config = true },
    },

    config = function()
        require('typescript-tools').setup {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            expose_as_code_action = 'all',
            code_lens = 'true',
        }
    end,
}
