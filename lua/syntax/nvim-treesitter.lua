local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  error("can't find nvim-treesitter")
end

require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

treesitter.setup({
  -- Install language parser
  -- :TSInstallInfo show the languages have been supported
  ensure_installed = { "rust", "awk", "c_sharp", "bash", "c", "cpp", "lua", "vim", "json", "markdown", "markdown_inline" },

  -- enable code highlight
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  auto_install = true,
  -- enable indent
  indent = {
    enable = true,
  },
})

-- enable code folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- don't auto fold code
-- -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99
