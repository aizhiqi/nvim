local auto_load_lsp = vim.api.nvim_create_augroup("auto_load_lsp", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

local plugins_loaded = {}

local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

autocmd("FileType", {
  group = auto_load_lsp,
  pattern = "*",
  callback = function()
    if Set(plugins_loaded)[vim.bo.filetype] then
      return
    end

    table.insert(plugins_loaded, vim.bo.filetype)

    if vim.bo.filetype == "cpp" then
      require("lsp.setup").setup("clangd");
      vim.notify("lsp clangd started")

    elseif vim.bo.filetype == "lua" then
      require("lsp.setup").setup("lua_ls", require("lsp.config.lua").settings)
      require("neodev").setup({})
      vim.notify("lsp lua_ls started and plugin neodev loaded")

    elseif vim.bo.filetype == "json" then
      require("lsp.setup").setup("jsonls", require("lsp.config.json").settings)
      vim.notify("lsp schemastore loaded")

    elseif vim.bo.filetype == "rust" then
      require("lsp.setup").rust_setup()
      vim.notify("lsp rust-tools loaded")

    elseif vim.bo.filetype == "sh" then
      require("lsp.setup").setup("bashls")
      vim.notify("lsp bashls loaded")

    elseif vim.bo.filetype == "dart" then
      require("lsp.setup").flutter_setup()
      vim.notify("lsp flutter-tools loaded")

    elseif vim.bo.filetype == "cs" then
      -- require("lsp.setup").setup("csharp_ls");
      -- vim.notify("lsp csharp_ls loaded")
      require("lsp.setup").setup("omnisharp");
      vim.notify("lsp omnisharp loaded")

    elseif vim.bo.filetype == "xml" then
      require("lsp.setup").setup("lemminx");
      vim.notify("lsp lemminx loaded")

    else
      return
    end

    -- reload current buffer
    vim.cmd("edit " .. vim.fn.bufname())
  end
})
