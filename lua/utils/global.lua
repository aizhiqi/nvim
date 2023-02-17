function _G.log(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

function _G.requirePlugin(name)
  local status_ok, plugin = pcall(require, name)
  if not status_ok then
    vim.notify(" can't find plugin：" .. name)
    return nil
  end
  return plugin
end

function _G.lspCap()
  print(vim.inspect(vim.lsp.buf_get_clients()[1].resolved_capabilities))
end
