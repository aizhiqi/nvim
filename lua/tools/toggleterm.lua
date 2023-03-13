local status, toggleterm = pcall(require, "toggleterm")
if not status then
  error("can't find toggleterm")
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
})

local Terminal = require("toggleterm.terminal").Terminal

local tf = Terminal:new({
  direction = "float",
  close_on_exit = true,
})

local tl = Terminal:new({
  direction = "vertical",
  close_on_exit = true,
})

local tj = Terminal:new({
  direction = "horizontal",
  close_on_exit = true,
})

local M = {}

M.toggleF = function()
  if tf:is_open() then
    tf:close()
    return
  end
  tl:close()
  tj:close()
  tf:open()
end

M.toggleL = function()
  if tl:is_open() then
    tl:close()
    return
  end
  tf:close()
  tj:close()
  tl:open()
end

M.toggleJ = function()
  if tj:is_open() then
    tj:close()
    return
  end
  tl:close()
  tl:close()
  tj:open()
end

return M
