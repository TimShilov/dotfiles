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

local function process_json_schema_objects(bufnr, objects)
  -- Ensure buffer number is set
  bufnr = bufnr or 0

  -- Create namespace for highlights
  local hl_ns = vim.api.nvim_create_namespace 'json_schema_required_props'

  -- Create namespace for diagnostics
  local diag_ns = vim.api.nvim_create_namespace 'json_schema_diagnostics'

  -- Clear previous highlights and diagnostics
  vim.api.nvim_buf_clear_namespace(bufnr, hl_ns, 0, -1)
  vim.api.nvim_buf_clear_namespace(bufnr, diag_ns, 0, -1)

  -- Create a query to find the 'required' array and 'properties' object
  local required_query = vim.treesitter.query.parse(
    'typescript',
    [[
        (pair
            key: (property_identifier) @required_key
            (#eq? @required_key "required")
            value: (array) @required_array
        ) @required_pair

        (pair
            key: (property_identifier) @properties_key
            (#eq? @properties_key "properties")
            value: (object) @properties_object
        ) @properties_pair
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

  -- Function to extract defined property names
  local function extract_defined_props(properties_node)
    local props = {}
    for child in properties_node:iter_children() do
      if child:type() == 'pair' then
        local key_node = child:child(0)
        if key_node and key_node:type() == 'property_identifier' then
          local prop = vim.treesitter.get_node_text(key_node, bufnr)
          props[prop] = true
        end
      end
    end
    return props
  end

  -- Collect diagnostics
  local diagnostics = {}

  -- Process each object
  for _, object in ipairs(objects) do
    local required_array_node = nil
    local properties_object_node = nil
    local required_props = {}
    local defined_props = {}

    -- Find required and properties nodes
    for _, match, _ in required_query:iter_matches(object, bufnr) do
      for id, node in pairs(match) do
        local capture_name = required_query.captures[id]
        if capture_name == 'required_array' then
          required_array_node = node
        elseif capture_name == 'properties_object' then
          properties_object_node = node
        end
      end
    end

    -- Extract required and defined properties
    if required_array_node then
      required_props = extract_required_props(required_array_node)
    end
    if properties_object_node then
      defined_props = extract_defined_props(properties_object_node)
    end

    -- Highlight and diagnose required properties
    if #required_props > 0 then
      -- Highlight defined required properties
      for _, prop in ipairs(required_props) do
        if defined_props[prop] then
          -- Highlight defined required properties
          local prop_query = vim.treesitter.query.parse(
            'typescript',
            string.format(
              [[
                  (pair
                      key: (property_identifier) @key
                      (#eq? @key "%s")
                  ) @prop_pair
              ]],
              prop
            )
          )

          for _, match, _ in prop_query:iter_matches(object, bufnr) do
            local prop_node = match[1] -- the property key node

            -- Get node range
            local start_row, start_col, end_row, end_col = prop_node:range()

            -- Highlight the property
            vim.api.nvim_buf_add_highlight(bufnr, hl_ns, '@text.emphasis', start_row, start_col, end_col)
          end
        else
          -- Find the specific string node for the undefined property
          local prop_query = vim.treesitter.query.parse(
            'typescript',
            [[
            (pair
                key: (property_identifier) @required_key
                (#eq? @required_key "required")
                value: (array (string) @prop_string)
            ) @required_pair
          ]]
          )

          for _, match, _ in prop_query:iter_matches(object, bufnr) do
            for id, node in pairs(match) do
              local capture_name = prop_query.captures[id]
              if capture_name == 'prop_string' then
                local prop_text = vim.treesitter.get_node_text(node, bufnr):gsub('^"', ''):gsub('"$', '')

                if prop_text == prop and not defined_props[prop] then
                  -- Get precise location of this specific string node
                  local start_row, start_col, end_row, end_col = node:range()

                  table.insert(diagnostics, {
                    lnum = start_row,
                    col = start_col,
                    end_lnum = end_row,
                    end_col = end_col,
                    severity = vim.diagnostic.severity.ERROR,
                    message = string.format("Required property '%s' is not defined in properties", prop),
                    source = 'json-schema-validator',
                  })
                end
              end
            end
          end
        end
      end
    end
  end

  -- Set diagnostics
  vim.diagnostic.set(diag_ns, bufnr, diagnostics, {})
end

M.setup = function()
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufWrite', 'TextChanged' }, {
    pattern = { 'schema.ts', 'schema.js' },
    callback = function(args)
      local bufnr = args.buf
      local objects = find_json_schema_objects()
      process_json_schema_objects(bufnr, objects)
    end,
  })
end

return M
