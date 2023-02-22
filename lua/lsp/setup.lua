Lsp = {}

local status, mason, mason_lspconfig = pcall(function()
  return require("mason"), require("mason-lspconfig")
end)
if not status then
  vim.notify("can't find mason or mason-lspconfig")
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

mason_lspconfig.setup({
  --ensure_installed = { "lua_ls", "awk_ls", "bashls", "clangd", "jsonls", "marksman", "jedi_language_server", "csharp_ls" },

  -- All servers set up via lspconfig
  automatic_installation = true,
})



local on_attach = function(client, bufnr)
  -- default keymap
  --[[ -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts) ]]
  -- use keybindings's keymap
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  require("keybindings").mapLSP(buf_set_keymap)

  -- enable use lsp formatting?
  client.server_capabilities.document_formatting = true
  client.server_capabilities.document_range_formatting = true
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_flags = {
  debounce_text_changes = 150,
}

function Lsp.rust_setup()
  require("rust-tools").setup {
    server = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
      settings = require("lsp.config.rust")
    }
  }
end

function Lsp.setup(server_name, settings)
  require("lspconfig")[server_name].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = settings or {}
  }
end

--[[
-- eg:
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
} ]]
return Lsp
