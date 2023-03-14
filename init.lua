require("global")

-- install configration
G.lsp_ui = true
G.colorscheme = false

-- base plugin (require nothing)
require("basic")
require("plugins")

-- ui componets
require("ui.nvim-tree")
require("ui.lualine")
require("ui.telescope")
require("ui.project")
require("ui.tokynight")

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

-- advance configration(require plugins above)
require("keybindings")
require("autocmds")
require("colorscheme")
