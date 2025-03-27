local M = {}

local function find_json_schema_objects(bufnr)
  -- Ensure buffer number is set
  bufnr = bufnr or 0

  -- Ensure Treesitter is available
  local parser = vim.treesitter.get_parser(bufnr, 'typescript')
  if not parser then
    return {}
  end

  -- Create a query to find objects with type: "object"
  local query = vim.treesitter.query.parse(
    'typescript',
    [[
      (object
          (pair
              key: (property_identifier) @type_key
              (#eq? @type_key "type")
              value: (string) @type_value
              (#eq? @type_value "\"object\"")
          )
      ) @schema_object
  ]]
  )

  local schema_objects = {}

  -- Iterate through the tree
  for _, tree in ipairs(parser:trees()) do
    local root = tree:root()

    for _, match, _ in query:iter_matches(root, bufnr) do
      local type_node = match[1] -- type key node

      -- Get the parent of the type pair (which should be the object)
      local object_node = type_node:parent():parent()

      -- Store the object node
      table.insert(schema_objects, object_node)
    end
  end

  return schema_objects
end

local function highlight_required_properties(bufnr, objects, hl_group)
  -- Ensure buffer number is set
  bufnr = bufnr or 0

  -- Default highlight group
  hl_group = hl_group or 'ErrorMsg'

  -- Create namespace for highlights
  local ns = vim.api.nvim_create_namespace 'json_schema_required_props'

  -- Clear previous highlights in this namespace
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  -- Create a query to find the 'required' array
  local required_query = vim.treesitter.query.parse(
    'typescript',
    [[
        (pair
            key: (property_identifier) @key
            (#eq? @key "required")
            value: (array) @required_array
        ) @required_pair
    ]]
  )

  -- Function to extract string values from an array node
  local function extract_required_props(array_node)
    local props = {}
    for child in array_node:iter_children() do
      if child:type() == 'string' then
        local prop = vim.treesitter.get_node_text(child, bufnr)
        -- Remove quotes
        prop = prop:gsub('^"', ''):gsub('"$', '')
        table.insert(props, prop)
      end
    end
    return props
  end

  -- Collect all required properties
  local all_required_props = {}
  for _, object in ipairs(objects) do
    for _, match, _ in required_query:iter_matches(object, bufnr) do
      local array_node = match[2] -- the required array node

      -- Extract property names
      local required_props = extract_required_props(array_node)

      -- Add to total list
      for _, prop in ipairs(required_props) do
        table.insert(all_required_props, prop)
      end
    end
  end

  -- Build a single query with all properties
  if #all_required_props > 0 then
    -- Escape special characters in property names
    local escaped_props = {}
    for _, prop in ipairs(all_required_props) do
      table.insert(escaped_props, string.format('"%s"', prop:gsub('"', '\\"')))
    end

    -- Create query with multiple alternatives
    local multi_prop_query = vim.treesitter.query.parse(
      'typescript',
      string.format(
        [[
            (pair
                key: (property_identifier) @key
                (#any-of? @key %s)
            ) @prop_pair
        ]],
        table.concat(escaped_props, ' ')
      )
    )

    -- Highlight matching properties
    for _, object in ipairs(objects) do
      for _, match, _ in multi_prop_query:iter_matches(object, bufnr) do
        local prop_node = match[1] -- the property key node

        -- Get node range
        local start_row, start_col, end_row, end_col = prop_node:range()

        -- vim.api.nvim_buf_set_extmark(0, ns, start_row, start_col - 2, {
        --     virt_text = { { "!", "@text.emphasis" } }, -- Icon with a Comment highlight
        --     virt_text_pos = "overlay", -- Alternatives: "eol", "right_align"
        -- })
        -- Highlight the property
        vim.api.nvim_buf_add_highlight(bufnr, ns, '@text.emphasis', start_row, start_col, end_col)
      end
    end
  end
end

M.setup = function()
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufWrite', 'TextChanged' }, {
    pattern = { '*.ts', '*.json' },
    callback = function(args)
      local bufnr = args.buf
      local objects = find_json_schema_objects()
      highlight_required_properties(bufnr, objects, 'MiniSnippetsCurrentReplace')
    end,
  })
end

return M
