local status, which_key = pcall(require, "which-key")
if not status then
  error("can't find which-key")
end


which_key.setup({
})

return {
  register = function(mode, key, cmd, opt)
    which_key.add({
      { key, cmd, desc = opt.desc or cmd, buffer = opt.buffer, noremap = opt.noremap, slient = opt.slient, nowait = opt.nowait, mode = mode},
    })
  end,

  register_group = function(key, group)
    which_key.add({
      { key, group = group },
    })
  end,
}
