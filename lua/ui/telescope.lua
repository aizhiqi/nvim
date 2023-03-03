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


local openfile = require ('nvim-tree.actions.node.open-file')
local actions = require ('telescope.actions')
local action_state = require ('telescope.actions.state')
local M = {}

local view_selection = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local filename = selection.filename
    if (filename == nil) then
      filename = selection[1]
    end
    openfile.fn('preview', filename)
  end)
  return true
end

function M.launch_live_grep(opts)
  if not M.launch_telescope("live_grep", opts) then
    vim.cmd("Telescope live_grep")
  end
end

function M.launch_find_files(opts)
  if not M.launch_telescope("find_files", opts) then
    vim.cmd("Telescope find_files")
  end
end

function M.launch_telescope(func_name, opts)
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return false
  end
  local lib_status_ok, lib = pcall(require, "nvim-tree.lib")
  if not lib_status_ok then
    return false
  end
  local node_status_ok, node = pcall(lib.get_node_at_cursor)
  if(not node_status_ok or node == nil) then
    return false
  end
  local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  if (node.name == '..' and TreeExplorer ~= nil) then
    basedir = TreeExplorer.cwd
  end
  if basedir == nil then
    return false
  end

  vim.notify("telescope in directory:" .. basedir)
  opts = opts or {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  opts.attach_mappings = view_selection
  require("telescope.builtin")[func_name](opts)
  return true
end

return M
