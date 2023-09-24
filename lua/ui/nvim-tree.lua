local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  error("can't find nvim-tree")
end

nvim_tree.setup({
  -- disable buildin netrw
  disable_netrw = true,
  -- show icon for git
  git = {
    enable = true,
  },
  -- project plugin need this
  update_cwd = true,
  update_focused_file = {
    enable = false,
    update_cwd = true,
  },
  filters = {
    -- hide dofiles
    dotfiles = true,
    -- hide node_modules directory
    -- custom = { "node_modules" },
  },
  view = {
    width = 34,
    side = "left",
    --mappings = {
    --  custom_only = true,
    --  list = list_keys,
    --},
    -- don't show line number
    number = false,
    relativenumber = false,
    -- show icon for item
    signcolumn = "yes",
  },
  actions = {
    open_file = {
      -- auto adjust size when the first time show
      resize_window = true,
      -- auto close tree after file opend
      quit_on_open = false,
    },
  },
  -- wsl install -g wsl-open
  -- https://github.com/4U6U57/wsl-open/
  system_open = {
    -- mac
    cmd = "open",
    -- windows
    -- cmd = "wsl-open",
  },
  on_attach = require("keybindings").nvimTreeList,
})

return nvim_tree
