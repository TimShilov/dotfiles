return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
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
}
