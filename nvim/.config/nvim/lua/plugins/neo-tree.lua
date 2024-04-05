return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    auto_clean_after_session_restore = true,
    event_handlers = {
      {
        event = 'neo_tree_buffer_leave',
        handler = function()
          print 'NeoTree buffer leave'
          local shown_buffers = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            shown_buffers[vim.api.nvim_win_get_buf(win)] = true
          end
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if
              not shown_buffers[buf]
              and vim.api.nvim_buf_get_option(buf, 'buftype') == 'nofile'
              and vim.api.nvim_buf_get_option(buf, 'filetype') == 'neo-tree'
            then
              vim.api.nvim_buf_delete(buf, {})
            end
          end
        end,
      },
    },
    filesystem = {
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_hidden = false,
      },
    },
  },
  config = function()
    require 'plugins.neo-tree'
    vim.keymap.set('n', '<leader>n', ':Neotree reveal<CR>', { desc = 'Toggle NeoTree' })
  end,
}
