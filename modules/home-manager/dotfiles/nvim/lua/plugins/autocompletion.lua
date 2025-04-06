return {
  'saghen/blink.cmp',
  dependencies = {
    -- optional: provides snippets for the snippet source
    'rafamadriz/friendly-snippets',
    {
      'Kaiser-Yang/blink-cmp-git',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    'moyiz/blink-emoji.nvim',
  },
  version = 'v0.*',
  event = 'InsertEnter',

  opts = {
    cmdline = {
      completion = { menu = { auto_show = true } },
    },
    keymap = {
      preset = 'default',

      ['<C-n>'] = { 'select_next', 'show', 'fallback' },
    },
    completion = {
      menu = {
        border = 'rounded',
        draw = {
          columns = { { 'label', 'label_description', 'source_name', gap = 1 }, { 'kind_icon', 'kind', gap = 1 } },
          treesitter = { 'lsp' },
        },
      },
      documentation = { auto_show = true, window = { border = 'rounded' } },
      accept = { dot_repeat = false },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'git', 'omni', 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'emoji' },
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
