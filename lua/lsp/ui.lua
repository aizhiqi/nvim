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
local status, lspkind, lspsaga, symbols_outline = pcall(function()
  return require("lspkind"), require("lspsaga"), require("symbols-outline")
end)
if not status then
  vim.notify("can't find plugin kspkind or lspsaga or symbols-outline")
  return
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
  --outline = {
  --  win_position = "right",
  --  win_with = "",
  --  win_width = 30,
  --  show_detail = true,
  --  auto_preview = true,
  --  auto_refresh = true,
  --  auto_close = true,
  --  custom_sort = nil,
  --  keys = {
  --    jump = "o",
  --    expand_collapse = "u",
  --    quit = "q",
  --  },
  --},

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
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { icon = "", hl = "@text.uri" },
    Module = { icon = "", hl = "@namespace" },
    Namespace = { icon = "", hl = "@namespace" },
    Package = { icon = "", hl = "@namespace" },
    Class = { icon = "𝓒", hl = "@type" },
    Method = { icon = "ƒ", hl = "@method" },
    Property = { icon = "", hl = "@method" },
    Field = { icon = "", hl = "@field" },
    Constructor = { icon = "", hl = "@constructor" },
    Enum = { icon = "ℰ", hl = "@type" },
    Interface = { icon = "ﰮ", hl = "@type" },
    Function = { icon = "", hl = "@function" },
    Variable = { icon = "", hl = "@constant" },
    Constant = { icon = "", hl = "@constant" },
    String = { icon = "𝓐", hl = "@string" },
    Number = { icon = "#", hl = "@number" },
    Boolean = { icon = "⊨", hl = "@boolean" },
    Array = { icon = "", hl = "@constant" },
    Object = { icon = "⦿", hl = "@type" },
    Key = { icon = "🔐", hl = "@type" },
    Null = { icon = "NULL", hl = "@type" },
    EnumMember = { icon = "", hl = "@field" },
    Struct = { icon = "𝓢", hl = "@type" },
    Event = { icon = "🗲", hl = "@type" },
    Operator = { icon = "+", hl = "@operator" },
    TypeParameter = { icon = "𝙏", hl = "@parameter" },
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
  },
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
