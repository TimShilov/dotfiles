return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
    'yioneko/nvim-vtsls', -- TODO: See if can be replaced with 'LspTypescriptSourceAction' command
  },
  cmd = { 'Mason' },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      -- Create a function that lets us more easily define mappings specific LSP related items.
      -- It sets the mode, buffer and description for us each time.
      callback = function(event)
        local map = function(mode, keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map('n', '<leader>lr', '<cmd>LspRestart<cr>', '[L]SP [R]estart')

        vim.api.nvim_create_autocmd('BufWritePre', {
          pattern = { '*.js', '*.ts', '*.cjs', '*.mjs', '*.cts', '*.mts' },
          command = 'silent! LspEslintFixAll',
          group = vim.api.nvim_create_augroup('LspEslintFixAll', {}),
        })

        vim.api.nvim_create_autocmd('BufWritePre', {
          pattern = { '*.js', '*.ts', '*.cjs', '*.mjs', '*.cts', '*.mts' },
          group = vim.api.nvim_create_augroup('TypescriptFormatOnSave', {}),
          callback = function()
            vim.cmd 'silent! VtsExec remove_unused_imports'
            vim.cmd 'silent! VtsExec add_missing_imports'
          end,
        })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    -- Enable the following language servers
    local servers = {
      'js-debug-adapter',
      'actionlint',
      'bashls',
      'terraformls',
      'docker_compose_language_service',
      'dockerls',
      'eslint',
      -- BEGIN GO
      'gopls',
      'delve',
      'impl',
      -- END GO
      'oxlint',
      'nixd',
      'hadolint',
      'helm_ls',
      'jsonls',
      'nxls',
      'lua_ls',
      'omnisharp',
      'prismals',
      'sqlls',
      'taplo',
      'yamlls',
      'vtsls',
    }
    local formatters = {
      'fixjson',
      'gofumpt',
      'goimports',
      'gomodifytags',
      'terraform',
      'jq',
      'nixpkgs-fmt',
      'npm-groovy-lint',
      'prettier',
      'shfmt',
      'sql-formatter',
      'sqruff',
      'stylua',
    }

    -- Ensure the servers and tools above are installed
    require('mason').setup {}

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_extend('keep', formatters, servers)
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      auto_update = true,
    }

    require('mason-lspconfig').setup {}
  end,
}
