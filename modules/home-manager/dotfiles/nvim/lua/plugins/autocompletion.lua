return {
  'saghen/blink.cmp',
  dependencies = {
    -- optional: provides snippets for the snippet source
    'rafamadriz/friendly-snippets',
    'echasnovski/mini.snippets',
    'fang2hou/blink-copilot',
  },
  version = 'v0.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    snippets = { preset = 'mini_snippets' },
    completion = {
      menu = {
        auto_show = function()
          return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false and vim.bo.filetype ~= 'TelescopePrompt'
        end,
        border = 'rounded',
        draw = {
          columns = { { 'label', 'label_description', 'source_name', gap = 1 }, { 'kind_icon', 'kind', gap = 1 } },
          treesitter = { 'lsp' },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = 'rounded' } },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    signature = {
      window = { border = 'rounded' },
      enabled = true,
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-copilot',
          enabled = true,
          score_offset = 100,
          async = true,
          opts = {
            max_attempts = 2,
            max_completions = 3,
          },
        },
        lazydev = {
          enabled = true,
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
