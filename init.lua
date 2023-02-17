-- base plugin
require("basic")
require("keybindings")
require("plugins")
require("colorscheme")
require("autocmds")

-- ui componets
require("plugin-config.nvim-tree")
require("plugin-config.lualine")
require("plugin-config.telescope")
require("plugin-config.project")

-- code analyze and highlight
require("plugin-config.nvim-treesitter")
require("plugin-config.indent-blankline")
require("plugin-config.fidget")
require("plugin-config.nvim-autopairs")
require("plugin-config.comment")

-- LSP
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")

-- Tools
require("plugin-config.gitsigns")
require("plugin-config.toggleterm")

-- debugger
require("dap.vimspector")
