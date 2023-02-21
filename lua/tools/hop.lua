local status, hop= pcall(require, "hop")
if not status then
  vim.notify("can't find hop")
  return
end

local directions = require('hop.hint').HintDirection

hop.setup({ 
  keys = "etovxqpdygfblzhckisuran",
})
