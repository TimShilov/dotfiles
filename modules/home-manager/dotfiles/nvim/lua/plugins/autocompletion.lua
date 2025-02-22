return {
  'saghen/blink.cmp',
  dependencies = {
    -- optional: provides snippets for the snippet source
    'rafamadriz/friendly-snippets',
    'echasnovski/mini.snippets',
    {
      'Kaiser-Yang/blink-cmp-git',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    'moyiz/blink-emoji.nvim',
  },
  version = 'v0.*',

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
      default = { 'git', 'omni', 'cmdline', 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'emoji' },
      providers = {
        lazydev = {
          enabled = true,
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        git = {
          module = 'blink-cmp-git',
          name = 'Git',
          enabled = function()
            return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
          end,
        },
        emoji = {
          module = 'blink-emoji',
          name = 'Emoji',
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
          should_show_items = function()
            return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.o.filetype)
          end,
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
