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
  end,
})

return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    -- Enable the following language servers
    local servers = {
      'js-debug-adapter',
      'actionlint',
      'sonarlint-language-server',
      'bashls',
      'vacuum',
      'terraformls',
      'docker_compose_language_service',
      'dockerls',
      'eslint',
      'gh_actions_ls',
      -- BEGIN GO
      'gopls',
      'delve',
      'impl',
      -- END GO
      'oxlint',
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
    local ensure_installed = vim.tbl_extend('force', formatters, servers)
    require('mason').setup(opts)
    require('mason-lspconfig').setup {}
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
    }

    -- TODO: Find a way to use Mason to install cspell_ls
    vim.lsp.enable 'cspell_ls'
  end,
}
