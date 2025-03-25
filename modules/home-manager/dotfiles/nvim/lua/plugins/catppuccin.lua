return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    transparent_background = true,
    default_integrations = true,
    integrations = {
      blink_cmp = true,
      dadbod_ui = true,
      dropbar = { enabled = true, color_mode = true },
      fidget = true,
      gitsigns = true,
      grug_far = true,
      lsp_trouble = true,
      markdown = true,
      mini = { enabled = true },
      neotest = true,
      noice = true,
      octo = true,
      overseer = true,
      render_markdown = true,
      semantic_tokens = true,
      snacks = { enabled = true, indent_scope_color = 'lavender' },
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
          ok = { 'italic' },
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'underline' },
          ok = { 'underline' },
        },
        inlay_hints = {
          background = true,
        },
      },
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
