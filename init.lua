require("global")
G.lsp_ui = true

-- base plugin
require("basic")
require("keybindings")
require("plugins")
require("colorscheme")
require("autocmds")

-- ui componets
require("ui.nvim-tree")
require("ui.lualine")
require("ui.telescope")
require("ui.project")

-- code analyze and highlight
require("syntax.nvim-treesitter")
require("syntax.indent-blankline")
require("syntax.nvim-autopairs")
require("syntax.comment")

-- LSP
require("lsp.setup")
require("lsp.cmp")

-- Tools
require("tools.gitsigns")
require("tools.toggleterm")
require("tools.hop")

-- debugger
require("dap.vimspector")
