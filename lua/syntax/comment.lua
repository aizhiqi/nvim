local status, comment = pcall(require, "Comment")
if not status then
  vim.notify("can't find Comment")
  return
end

local default_opts = {
  ---Add a space b/w comment and the line
  ---@type boolean|fun():boolean
  padding = true,

  ---Whether the cursor should stay at its position
  ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
  ---@type boolean
  sticky = true,

  ---Lines to be ignored while comment/uncomment.
  ---Could be a regex string or a function that returns a regex string.
  ---Example: Use '^$' to ignore empty lines
  ---@type string|fun():string
  ignore = nil,


  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---NOTE: If `mappings = false` then the plugin won't create any mappings
  ---@type boolean|table
  mappings = {
    ---Operator-pending mapping
    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    ---Extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = false,
    ---Extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

  ---Pre-hook, called before commenting the line
  ---@type fun(ctx: Ctx):string
  pre_hook = nil,

  ---Post-hook, called after commenting is done
  ---@type fun(ctx: Ctx)
  post_hook = nil,
}

-- don't use extra keybinding ，only keybindings in keybindings.lua are allowed
comment.setup(vim.tbl_deep_extend("force", default_opts, require("keybindings").comment))
