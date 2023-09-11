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


-- outline
local status, symbols_outline, trouble = pcall(function()
  return require("symbols-outline"), require("trouble")
end)
if not status then
  error("can't find plugin symbols-outline or trouble")
end


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
    open_split = { "sp" },        -- open buffer in new split
    open_vsplit = { "vs" },       -- open buffer in new vsplit
    open_tab = { "t" },          -- open buffer in new tab
    jump_close = { "o" },            -- jump to the diagnostic and close the list
    toggle_mode = "m",               -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P",            -- toggle auto_preview
    hover = "h",                     -- opens a small popup with the full multiline message
    preview = "p",                   -- preview the diagnostic location
    close_folds = { "zC" },    -- close all folds
    open_folds = { "zO" },     -- open all folds
    toggle_fold = { "zo", "za" },    -- toggle fold of current file
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
