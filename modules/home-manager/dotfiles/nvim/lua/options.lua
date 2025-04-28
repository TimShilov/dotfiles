-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- make sure filetype and highlighting work correctly after a session is restored
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.opt.exrc = true -- Enable per-directory .nvim.lua files

vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

vim.opt.hlsearch = false -- Set highlight on search
vim.opt.winborder = 'rounded'

vim.opt.scrolloff = 10 -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

vim.wo.number = true
vim.opt.relativenumber = true -- set relative numbered lines

vim.opt.whichwrap = 'bs<>[]hl' -- which "horizontal" keys are allowed to travel to prev/next line
vim.opt.wrap = false -- display lines as one long line
vim.opt.linebreak = true -- companion to wrap don't split words
vim.opt.cursorline = true

vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert n spaces for a tab
vim.opt.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.autoindent = true -- copy indent from current line when starting new one

vim.opt.shortmess:append 'c' -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append '-' -- hyphenated words recognized by searches

vim.opt.showtabline = 0 -- never show tabs
vim.opt.backspace = 'indent,eol,start' -- allow backspace on
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.mouse = 'a' -- Enable mouse mode

vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.

vim.opt.breakindent = true -- Enable break indent

vim.opt.fileencoding = 'utf-8' -- the encoding written to a file
vim.opt.undofile = true -- Save undo history
vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false -- creates a swapfile
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- separate vim plugins from neovim in case vim still in use

vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true -- smart case
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default

vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)

vim.opt.completeopt = 'menuone,noselect,fuzzy,preview' -- Set completeopt to have a better completion experience

vim.opt.termguicolors = true -- set termguicolors to enable highlight groups

vim.opt.spelllang = 'en_us' -- set spelllang to enable spell checking
vim.opt.spell = false

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
vim.diagnostic.config { underline = true, virtual_text = true, severity_sort = true }

-- Appearance of diagnostics
vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    -- Add a custom format function to show error codes
    format = function(diagnostic)
      -- local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      -- return string.format('%s %s', code, diagnostic.message)
      return diagnostic.message
    end,
  },
  severity_sort = true,
  underline = true,
  update_in_insert = true,
  float = {
    header = false,
    source = true,
    border = 'rounded',
    focusable = true,
  },
  -- Make diagnostic background transparent
  on_ready = function()
    vim.cmd 'highlight NormalFloat guibg=NONE'
  end,
}
