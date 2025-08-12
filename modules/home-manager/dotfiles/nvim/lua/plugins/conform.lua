---@module "conform"
---@type conform.setupOpts
local options = {
  formatters_by_ft = {
    lua = { 'stylua' },
    query = { 'format-queries' },
    nix = { 'nixfmt' },
    terraform = { 'terraform_fmt' },
    sh = { 'shfmt' },
    go = { 'goimports', 'gofumpt' },
    prisma = { lsp_format = 'prefer' },
    ['*'] = { 'prettier', 'injected' },
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
  format_on_save = { timeout_ms = 3000, lsp_format = 'fallback' },
  formatters = {
    injected = {},
    shfmt = {
      prepend_args = { '-i', '2' },
    },
    prettier = {
      prepend_args = { '-u' },
    },
  },
}

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = 'Code format',
    },
  },
  opts = options,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
