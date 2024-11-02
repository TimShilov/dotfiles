-- Define the sign as before
vim.fn.sign_define('return_line', { text = '⏎', texthl = 'CursorLineNr' })

-- Create the autocmd that uses Treesitter
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWrite' }, {
  pattern = '*.ts',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    -- Clear existing signs
    vim.fn.sign_unplace 'return_group'

    -- Get the buffer's parser
    local parser = vim.treesitter.get_parser(bufnr)
    if not parser then
      return
    end

    -- Get syntax tree
    local tree = parser:parse()[1]
    local root = tree:root()

    -- Create a query to find return statements
    local query = vim.treesitter.query.parse(parser:lang(), [[ (return_statement) @return ]])

    -- Iterate through all matches
    for _, match, _ in query:iter_matches(root, bufnr) do
      local node = match[1]
      local start_row = node:range()
      vim.fn.sign_place(0, 'return_group', 'return_line', bufnr, { lnum = start_row + 1 })
    end
  end,
})
