return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- See `:help lazygit`
    vim.keymap.set('n', '<leader>gg', require('lazygit').lazygit, { desc = 'Open LazyGit' })
  end,
}
