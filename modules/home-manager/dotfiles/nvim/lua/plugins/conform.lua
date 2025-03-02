return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    -- {
    --   '<leader>ff',
    --   function()
    --     require('conform').format { async = true }
    --   end,
    --   mode = '',
    --   desc = 'Format buffer',
    -- },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier', stop_after_first = true },
      typescript = { 'prettier', stop_after_first = true },
      json = { 'prettier', stop_after_first = true },
      query = { 'format-queries' },
      nix = { 'nixfmt' },
      go = { 'goimports', 'gofumpt' },
      ['*'] = { 'injected' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = { timeout_ms = 3000 },
    formatters = {
      injected = {},
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
