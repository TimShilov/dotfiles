return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    priority = 10000,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(client, bufnr)
        if client.name == 'eslint' then
          print 'eslint'
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end

        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps { buffer = bufnr, preserve_mappings = false }
        -- autoformat on save
        lsp_zero.buffer_autoformat()

        local map = function(mode, keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        map('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('n', 'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Lesser used LSP functionality
        map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        map('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')
      end)

      local cmp = require 'cmp'

      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ['<C-y>'] = cmp.mapping.confirm { select = true },
        },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'cmdline' },
          { name = 'buffer' },
        },
      }

      -- LUA --
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
      require('neodev').setup()

      -- MASON --
      -- see :help lsp-zero-guide:integrate-with-mason-nvim
      -- to learn how to use mason.nvim with lsp-zero
      require('mason').setup {}
      require('mason-lspconfig').setup {
        automatic_installation = true,
        handlers = {
          lsp_zero.default_setup,
        },
      }
    end,
  },
}
