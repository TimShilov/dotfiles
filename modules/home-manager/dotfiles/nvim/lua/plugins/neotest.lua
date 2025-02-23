return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
  },
  event = { 'BufReadPost' },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-vitest',
      },
    }
    vim.api.nvim_set_keymap('n', '<leader>twr', "<cmd>lua require('neotest').run.run({ vitestCommand = 'pnpm vitest run' })<cr>", { desc = 'Run Watch' })

    vim.api.nvim_set_keymap(
      'n',
      '<leader>twf',
      "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'pnpm vitest run' })<cr>",
      { desc = 'Run Watch File' }
    )
  end,
}
