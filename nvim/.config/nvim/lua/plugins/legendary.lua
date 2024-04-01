return {
  'mrjones2014/legendary.nvim',
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  opts = {
    extensions = {
      lazy_nvim = true,
      which_key = { use_groups = true, auto_register = false },
    },
  },
}
