-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- make sure filetype and highlighting work correctly after a session is restored
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.opt.exrc = true -- Enable per-directory .nvim.lua files

vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window

vim.o.hlsearch = false -- Set highlight on search

vim.o.scrolloff = 10 -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`

vim.wo.number = true
vim.o.relativenumber = true -- set relative numbered lines

vim.o.whichwrap = 'bs<>[]hl' -- which "horizontal" keys are allowed to travel to prev/next line
vim.o.wrap = false -- display lines as one long line
vim.o.linebreak = true -- companion to wrap don't split words
vim.o.cursorline = false -- highlight the current line

vim.o.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.o.tabstop = 4 -- insert n spaces for a tab
vim.o.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
vim.o.expandtab = true -- convert tabs to spaces
vim.o.smartindent = true -- make indenting smarter again
vim.o.autoindent = true -- copy indent from current line when starting new one

vim.opt.shortmess:append 'c' -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append '-' -- hyphenated words recognized by searches

vim.o.showtabline = 0 -- never show tabs
vim.o.backspace = 'indent,eol,start' -- allow backspace on
vim.o.pumheight = 10 -- pop up menu height
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.

vim.o.mouse = 'a' -- Enable mouse mode

vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.

vim.o.breakindent = true -- Enable break indent

vim.o.fileencoding = 'utf-8' -- the encoding written to a file
vim.o.undofile = true -- Save undo history
vim.o.backup = false -- creates a backup file
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.swapfile = false -- creates a swapfile
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- separate vim plugins from neovim in case vim still in use

vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true -- smart case

vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default

vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)

vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

vim.opt.termguicolors = true -- set termguicolors to enable highlight groups

vim.opt.spelllang = 'en_us' -- set spelllang to enable spell checking
vim.opt.spell = false

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

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
vim.filetype.add {
  extension = {
    ['http'] = 'http',
  },
}
