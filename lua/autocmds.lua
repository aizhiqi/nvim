local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- auto sync plugins if lua/plugins.lua modified
autocmd("BufWritePost", {
  group = myAutoGroup,
  -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
  callback = function()
    if vim.fn.expand("<afile>") == "lua/plugins.lua" then
      vim.api.nvim_command("source lua/plugins.lua")
      vim.api.nvim_command("PackerSync")
    end
  end,
})

-- don't comments if change line use 'o'
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
      - "o" -- O and o, don't continue comments
      + "r" -- But do continue when pressing enter.
  end,
})



local _plugins_loaded = {}
local function _Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end


autocmd("FileType", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    if _Set(_plugins_loaded)[vim.bo.filetype] then
      return
    end

    table.insert(_plugins_loaded, vim.bo.filetype)

    if _Set({"h", "hpp", "cc", "c", "cpp" })[vim.bo.filetype]  then

    elseif _Set({"lua"})[vim.bo.filetype] then
      require("neodev").setup({
        vim.notify("neodev auto loaded")
      })
      --[[ vim.lsp.start({
        name = "lua-language-server",
        cmd = { "lua-language-server" },
        before_init = require("neodev.lsp").before_init,
        root_dir = vim.fn.getcwd(),
        settings = { Lua = {} },
      }) ]]

    elseif _Set({"json"})[vim.bo.filetype] then
      require("schemastore").setup({
        vim.notify("schemastore auto loaded")
      })

    elseif _Set({"rs"})[vim.bo.filetype] then
      require("rust-tools").setup({
        vim.notify("rust-tools auto loaded")
      })

    else

    end


  end
})

--[[ autocmd("FileType", {
--  group = myAutoGroup,
--  pattern = "*.json",
--  callback = function()
--    require("schemastore").setup({
--      vim.notify("schemastore loaded")
--    })
--  end,
--})
--autocmd("FileType", {
--  group = myAutoGroup,
--  pattern = "*.rs",
--  callback = function()
--    require("rust-tools").setup({
--      vim.notify("rust-tools loaded")
--    })
--  end,
--})
--autocmd("FileType", {
--  group = myAutoGroup,
--  pattern = "*.lua",
--  callback = function()
--    require("neodev").setup({
--      vim.notify("neodev loaded")
--    })
--    -[[ vim.lsp.start({
--      name = "lua-language-server",
--      cmd = { "lua-language-server" },
--      before_init = require("neodev.lsp").before_init,
--      root_dir = vim.fn.getcwd(),
--      settings = { Lua = {} },
--    }) ]]
--  end,
--})

