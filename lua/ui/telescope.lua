local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("can't find telescope")
  return
end

telescope.setup({
  defaults = {
    -- the initial mode in popup window
    initial_mode = "insert",
    -- vertical , center , cursor
    layout_strategy = "horizontal",
    -- keybindings for popup window
    mappings = require("keybindings").telescopeList,
  },
  pickers = {
    find_files = {
      -- theme = "dropdown", -- options： dropdown, cursor, ivy
    },
  },
  extensions = {
  },
})

pcall(telescope.load_extension, "env")
