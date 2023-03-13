-- project file in :lua print(require("project_nvim.utils.path").historyfile)
-- eg: ~/.local/share/nvim/project_nvim/project_history
local status, project = pcall(require, "project_nvim")
if not status then
  error("can't find project_nvim")
end

vim.g.nvim_tree_respect_buf_cwd = 1
project.setup({
  detection_methods = { "pattern" },
  patterns = {
    "README.md",
    "Cargo.toml",
    "package.json",
    ".sln",
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
  },
})

local status_telescope, telescope = pcall(require, "telescope")
if not status_telescope then
  error("can't find telescope")
end
pcall(telescope.load_extension, "projects")
