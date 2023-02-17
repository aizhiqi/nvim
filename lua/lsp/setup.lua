require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "awk_ls", "bashls", "rust_analyzer", "clangd", "jsonls", "tsserver", "marksman", "jedi_language_server" },

  -- auto install Language Servers
  automatic_installation = true,
})

require("mason-lspconfig").setup_handlers {
  -- default handler
  function (server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        on_attach = function(client, bufnr)
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end
          require("keybindings").mapLSP(buf_set_keymap)
        end
      }
  end,

  -- specific handler(eg:a handler override for the `rust_analyzer`)
  --["rust_analyzer"] = function ()
  --    require("rust-tools").setup {}
  --end
}


