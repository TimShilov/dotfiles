return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
    'yioneko/nvim-vtsls',
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
        map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- map('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        -- map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- map('n', 'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        -- map('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        -- map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        -- map('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        --
        -- if client and client.server_capabilities.documentHighlightProvider then
        --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.document_highlight,
        --   })
        --
        --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        --     buffer = event.buf,
        --     callback = vim.lsp.buf.clear_references,
        --   })
        -- end

        vim.api.nvim_create_autocmd('BufWritePre', {
          pattern = { '*.[jt]sx', '*.[mc][jt]s', '*.[jt]s' },
          command = 'silent! EslintFixAll',
          group = vim.api.nvim_create_augroup('ESlintFixAll', {}),
        })

        vim.api.nvim_create_autocmd('BufWritePre', {
          pattern = { '*.ts', '*.[cm]ts' },
          group = vim.api.nvim_create_augroup('TypescriptFormatOnSave', {}),
          callback = function()
            vim.cmd 'silent! VtsExec remove_unused_imports'
          end,
        })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    -- Enable the following language servers
    local servers = {
      ['js-debug-adapter'] = {},
      ['nixpkgs-fmt'] = {},
      ['sql-formatter'] = {},
      actionlint = {},
      bashls = {},
      delve = {},
      vtsls = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = 'always' },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = 'literals' },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = true },
          },
        },
      },
      docker_compose_language_service = {},
      dockerls = {},
      eslint = {},
      fixjson = {},
      -- BEGIN GO
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
            semanticTokens = true,
          },
        },
      },
      goimports = {},
      gofumpt = {},
      gomodifytags = {},
      delve = {},
      impl = {},
      -- END GO
      oxlint = {},
      nixd = {
        cmd = { 'nixd' },
        filetypes = { 'nix' },
        settings = {
          nixd = {
            nixpkgs = { expr = 'import <nixpkgs> { }' },
            options = {
              nix_darwin = {
                expr = '(builtins.getFlake "/Users/tim.shilov/dotfiles").darwinConfigurations."client-Tim-Shilov".options',
              },
            },
          },
        },
      },

      groovyls = {},
      hadolint = {},
      helm_ls = {
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = 'yaml-language-server',
              filetypes_exclude = { 'helm' },
            },
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      nxls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = 'Replace',
            },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
            hint = { enable = true },
          },
        },
      },
      omnisharp = {},
      prettier = {},
      prismals = {},
      shfmt = {},
      sqlls = {},
      stylua = {},
      taplo = {},
      yamlls = {
        filetypes_exclude = { 'helm' },
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    }

    -- Decorate floating windows
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

    -- Ensure the servers and tools above are installed
    require('mason').setup {
      ui = { border = 'rounded' },
    }

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('lspconfig').nixd.setup(servers['nixd'])
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
