require("global")
G.lsp_ui = true

-- base plugin
require("basic")
require("plugins")
require("colorscheme")

-- ui componets
require("ui.nvim-tree")
require("ui.lualine")
require("ui.telescope")
require("ui.project")
--require("ui.noice")

-- code analyze and highlight
require("syntax.nvim-treesitter")
require("syntax.indent-blankline")
require("syntax.nvim-autopairs")
require("syntax.comment")

-- Tools
require("tools.gitsigns")
require("tools.toggleterm")
require("tools.hop")

-- LSP
require("lsp.setup")
require("lsp.cmp")

-- debugger
require("dap.vimspector")

-- advance configration
require("keybindings")
require("autocmds")
