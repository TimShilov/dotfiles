-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lua/lazy-bootstrap'

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require 'lua/lazy-plugins'

-- [[ Setting options ]]
require 'lua/options'

-- [[ Basic Keymaps ]]
require 'lua/keymaps'

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require 'lua/telescope-setup'

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require 'lua/treesitter-setup'

-- [[ Configure LSP ]]
-- (Language Server Protocol)
require 'lua/lsp-setup'

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
require 'lua/cmp-setup'
