return {
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
      },
      completion = {
        callSnippet = 'Replace',
      },
      telemetry = { enable = false },
      diagnostics = { disable = { 'missing-fields' } },
      hint = { enable = true },
    },
  },
}
