-- for conciseness
local opts = { noremap = true, silent = true }

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 's', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- save file
vim.keymap.set('n', '<leader>ww', '<cmd> w <CR>', { desc = 'Save file', noremap = true, silent = true })

-- save file without auto-formatting
vim.keymap.set('n', '<leader>wn', '<cmd>noautocmd w <CR>', { desc = 'Save file without auto-formatting', noremap = true, silent = true })

-- toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { desc = 'Toggle line wrapping', noremap = true, silent = true })

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message', noremap = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list', noremap = true })

vim.keymap.set('n', '<leader>jo', 'i{oneOf:[<esc>l%a]}<esc>hi', { desc = 'Wrap with oneOf', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ja', 'i{anyOf:[<esc>l%a]}<esc>hi', { desc = 'Wrap with anyOf', noremap = true, silent = true })
vim.keymap.set('n', '<leader>jn', 'i{anyOf:[<esc>l%a]}<esc>hi,{type:"null"}<esc>', { desc = 'Make nullable', noremap = true, silent = true })
vim.keymap.set('n', '<leader>jf', '<cmd>%!jq .<CR>', { desc = 'Format with jq', noremap = true, silent = true })

-- Source file
vim.keymap.set('n', '<leader>x', function()
  local ft = vim.bo.filetype
  if ft == 'lua' then
    vim.cmd 'luafile %'
    return
  end

  if ft == 'typescript' then
    local packageRoot = vim.fn.findfile('package.json', '.;')
    local cwd = packageRoot and vim.fn.getcwd() .. '/' .. vim.fn.fnamemodify(packageRoot, ':h') or vim.fn.getcwd()
    local filePath = vim.fn.expand '%:.'
    local absoluteFilePath = vim.fn.fnamemodify(filePath, ':p')
    local relativePath = absoluteFilePath:sub(#cwd + 2)
    local command = { 'pnpm', 'tsx', relativePath }

    local res = vim.system(command, { cwd = cwd, text = true }):wait()
    if res.code ~= 0 then
      Snacks.notify.error(res.stderr or 'Unknown error.')
      return
    end
    Snacks.notify(res.stdout)
    return
  end
end, { desc = 'Source file', noremap = true, silent = true })
