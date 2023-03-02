local auto_action_nvim = vim.api.nvim_create_augroup("auto_action_nvim", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- auto sync plugins if lua/plugins.lua modified
autocmd("BufWritePost", {
  group = auto_action_nvim,
  callback = function()
    if vim.fn.expand("<afile>") == "lua/plugins.lua" then
      vim.api.nvim_command("source lua/plugins.lua")
      vim.api.nvim_command("Lazy sync")
    end
  end,
})

-- don't comments if change line use 'o'
autocmd("BufEnter", {
  group = auto_action_nvim,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
  end,
})

-- auto load lsp
require("lsp.autocmds")
