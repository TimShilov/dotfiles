return {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
        require('package-info').setup {
            hide_up_to_date = true,
            hide_unstable_versions = true,
        }

        require('telescope').load_extension 'package_info'
    end,
}
