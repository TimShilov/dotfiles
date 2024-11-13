local telescopeDropdown = require('telescope.themes').get_dropdown

local defaults = {
  mappings = {
    i = {
      ['<C-u>'] = false,
      ['<C-d>'] = false,
    },
  },
  layout_config = { width = 0.95, height = 0.95 },
  pickers = {
    find_files = {
      theme = 'dropdown',
      hidden = true,
    },
  },
  file_ignore_patterns = { 'node_modules', 'package-lock.json', '__snapshots__', '*.snap', 'pnpm-lock.yaml' },
  path_display = { 'truncate' },
  extensions = {
    package_info = {},
  },
}

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-frecency.nvim',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    telescope.setup { defaults = defaults }
    -- Enable telescope fzf native, if installed
    telescope.load_extension 'fzf'
    telescope.load_extension 'frecency'

    -- Telescope live_grep in git root
    -- Function to find the git root directory based on the current buffer's path
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        builtin.live_grep {
          search_dirs = { git_root },
        }
      end
    end

    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', '<cmd>Telescope frecency<CR>', { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader>.', function()
      builtin.find_files { cwd = vim.fn.expand '%:p:h:h' }
    end, { desc = '[.] Find close files (at most 2 levels up)' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(telescopeDropdown {
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Common file shortcuts
    vim.keymap.set('n', '<leader>en', function()
      builtin.find_files { cwd = '~/.config/nvim' }
    end, { desc = '[E]dit [N]eovim' })

    vim.keymap.set('n', '<leader>sn', function()
      local search_file = vim.fn.input 'Enter filename: '
      builtin.find_files { hidden = true, search_file = search_file }
    end, { desc = '[S]earch by [N]ame' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files { hidden = true, file_ignore_patterns = { '.git' } }
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  end,
}
