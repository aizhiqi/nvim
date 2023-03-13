-- use customized icon
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- lspkind && lspsaga && outline
local status, lspkind, lspsaga, symbols_outline, trouble = pcall(function()
  return require("lspkind"), require("lspsaga"), require("symbols-outline"), require("trouble")
end)
if not status then
  error("can't find plugin kspkind, lspsaga, symbols-outline or trouble")
end

lspkind.init({
  -- default: true
  -- with_text = true,
  -- defines how annotations are shown
  -- default: symbol
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "symbol_text",
  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)

  -- default: 'default'
  preset = "codicons",
  -- override preset symbols

  -- default: {}
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
})

lspsaga.setup({
  -- ui
  ui = {
    title = true,
    border = "single",
    winblend = 0,
    expand = "",
    collapse = "",
    code_action = "💡",
    incoming = " ",
    outgoing = " ",
    hover = ' ',
    kind = {},
  },

  -- Default options
  preview = {
    lines_above = 0,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  request_timeout = 2000,

  -- A finder to show the defintion, reference and implementation 
  finder = {
    --percentage
    max_height = 0.5,
    force_max_height = false,
    keys = {
      jump_to = 'p',
      edit = { 'o', '<CR>' },
      vsplit = 'vs',
      split = 'sp',
      tabe = 't',
      tabnew = 'r',
      quit = { 'q' },
      close_in_preview = 'q'
    },
  },

  -- definition
  definition = {
    edit = "<C-c>o",
    vsplit = "<C-c>v",
    split = "<C-c>i",
    tabe = "<C-c>t",
    quit = "q",
  },

  -- code action
  code_action = {
    num_shortcut = true,
    show_server_name = false,
    extend_gitsigns = true,
    keys = {
      -- string | table type
      quit = "q",
      exec = "<CR>",
    },
  },

  --diagnostic
  diagnostic = {
    on_insert = true,
    on_insert_follow = false,
    insert_winblend = 0,
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
     --1 is max
    max_width = 0.7,
    custom_fix = nil,
    custom_msg = nil,
    text_hl_follow = false,
    border_follow = true,
    keys = {
      exec_action = "o",
      quit = "q",
      go_action = "g"
    },
  },

  -- rename
  rename = {
    quit = "<C-c>",
    exec = "<CR>",
    mark = "x",
    confirm = "<CR>",
    in_select = true,
  },

  -- outline
  outline = {
    win_position = "right",
    win_with = "",
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = "o",
      expand_collapse = "u",
      quit = "q",
    },
  },

  --callhierarchy
  callhierarchy = {
    show_detail = false,
    keys = {
      edit = "e",
      vsplit = "s",
      split = "i",
      tabe = "t",
      jump = "o",
      quit = "q",
      expand_collapse = "u",
    },
  },

  --symbol_in_winbar
  symbol_in_winbar = {
    enable = true,
    separator = " ",
    ignore_patterns={},
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
})


-- symbols outline
symbols_outline.setup({
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  wrap = false,
  keymaps = require("keybindings").outline(),
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { icon = "", hl = "@text.uri" },
    Module = { icon = "", hl = "@namespace" },
    Namespace = { icon = "", hl = "@namespace" },
    Package = { icon = "", hl = "@namespace" },
    Class = { icon = "ﴯ", hl = "@type" },
    Method = { icon = "", hl = "@method" },
    Property = { icon = "ﰠ", hl = "@method" },
    Field = { icon = "ﰠ", hl = "@field" },
    Constructor = { icon = "", hl = "@constructor" },
    Enum = { icon = "", hl = "@type" },
    Interface = { icon = "", hl = "@type" },
    Function = { icon = "", hl = "@function" },
    Variable = { icon = "", hl = "@constant" },
    Constant = { icon = "", hl = "@constant" },
    String = { icon = "", hl = "@string" },
    Number = { icon = "", hl = "@number" },
    Boolean = { icon = "⊨", hl = "@boolean" },
    Array = { icon = "", hl = "@constant" },
    Object = { icon = "⦿", hl = "@type" },
    Key = { icon = "", hl = "@type" },
    Null = { icon = "NULL", hl = "@type" },
    EnumMember = { icon = "", hl = "@field" },
    Struct = { icon = "פּ", hl = "@type" },
    Event = { icon = "", hl = "@type" },
    Operator = { icon = "", hl = "@operator" },
    TypeParameter = { icon = "𝙏", hl = "@parameter" },
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
  },
})

trouble.setup({
  position = "bottom",              -- position of the list can be: bottom, top, left, right
  height = 10,                      -- height of the trouble list when position is top or bottom
  width = 50,                       -- width of the list when position is left or right
  icons = true,                     -- use devicons for filenames
  mode = "workspace_diagnostics",   -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "",                -- icon used for open folds
  fold_closed = "",              -- icon used for closed folds
  group = true,                     -- group results by file
  padding = true,                   -- add an extra new line on top of the list
  action_keys = {
                                    -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    close = "q",                     -- close the list
    cancel = "<esc>",                -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r",                   -- manually refresh
    jump = { "<cr>", "<tab>" },      -- jump to the diagnostic or open / close folds
    open_split = { "<c-x>" },        -- open buffer in new split
    open_vsplit = { "<c-v>" },       -- open buffer in new vsplit
    open_tab = { "<c-t>" },          -- open buffer in new tab
    jump_close = { "o" },            -- jump to the diagnostic and close the list
    toggle_mode = "m",               -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P",            -- toggle auto_preview
    hover = "K",                     -- opens a small popup with the full multiline message
    preview = "p",                   -- preview the diagnostic location
    close_folds = { "zM", "zm" },    -- close all folds
    open_folds = { "zR", "zr" },     -- open all folds
    toggle_fold = { "zA", "za" },    -- toggle fold of current file
    previous = "k",                  -- previous item
    next = "j"                       -- next item
  },
  indent_lines = true,               -- add an indent guide below the fold icons
  auto_open = false,                 -- automatically open the list when you have diagnostics
  auto_close = false,                -- automatically close the list when you have no diagnostics
  auto_preview = true,               -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false,                 -- automatically fold a file trouble list at creation
  auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
  signs = {
    -- icons / text used for a diagnostic
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
  use_diagnostic_signs = false   -- enabling this will use the signs defined in your lsp client
})


local M = {}
-- customized ui for cmp.lua

M.formatting = {
  format = lspkind.cmp_format({
    mode = "symbol_text",
    --mode = 'symbol', -- show only symbol annotations

    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function(entry, vim_item)
      -- show item sourse
      vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
      return vim_item
    end,
  }),
}

return M
