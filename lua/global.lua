G = {
  lsp_ui = false,
  colorscheme = false
}

function G.log(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

function G.requirePlugin(name)
  local status_ok, plugin = pcall(require, name)
  if not status_ok then
    vim.notify(" can't find plugin：" .. name)
    return nil
  end
  return plugin
end

function G.lspCap()
  print(vim.inspect(vim.lsp.get_active_clients()[1].resolved_capabilities))
end

return G
