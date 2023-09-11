-- lspkind && lspsaga && outline
local status, lspkind, lspsaga = pcall(function()
  return require("lspkind"), require("lspsaga")
end)
if not status then
  error("can't find plugin kspkind, lspsaga")
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
    border = "rounded",
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
    edit = "o",
    vsplit = "vs",
    split = "sp",
    tabe = "t",
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
      vsplit = "vs",
      split = "sp",
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
