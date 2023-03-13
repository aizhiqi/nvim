local status, hop = pcall(require, "hop")
if not status then
  error("can't find hop")
end

local directions = require('hop.hint').HintDirection

hop.setup({
  keys = "etovxqpdygfblzhckisuran",
})
