local status, hop = pcall(require, "hop")
if not status then
  error("can't find hop")
end

hop.setup({
  keys = "etovxqpdygfblzhckisuran",
})
