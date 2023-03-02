-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- leader key is bank key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.mapHelperleader = "\\"

local default_opt = {
  noremap = true,
  silent = true,
}

-- keybindings for plugin
local pluginKeys = {}

-- define map function
local map = function (...)
  local helper_key = select(1, ...)
  local mode = select(2, ...)
  local key = select(3, ...)
  local cmd = select(4, ...)
  local opt = select(5, ...)

  vim.api.nvim_set_keymap(mode, "<leader>" .. key, cmd, opt)

  key = vim.g.mapHelperleader .. helper_key .. key
  require("tools.whichkey").register(mode, key, cmd, opt)
end

local group = function (key, group)
  require("tools.whichkey").register_group(vim.g.mapHelperleader .. key, group)
end

--------------------------------------------------------------------
local base_helper_key = "b"
group(base_helper_key, "base operation")
-- quit
map(base_helper_key, "n", "q", "<cmd>q<CR>", default_opt)
map(base_helper_key, "n", "w", "<cmd>w<CR>", default_opt)

-- don't copy text in visual mode after paste
-- map(base_helper_key, "v", "p", '"_dP', default_opt)
vim.api.nvim_set_keymap("v", "p", '"_dP', default_opt)

--  + hjkl switch window
map(base_helper_key, "n", "h", "<C-w>h", default_opt)
map(base_helper_key, "n", "j", "<C-w>j", default_opt)
map(base_helper_key, "n", "k", "<C-w>k", default_opt)
map(base_helper_key, "n", "l", "<C-w>l", default_opt)

-- adjust window size
map(base_helper_key, "n", "<S-Left>", "<cmd>vertical resize -10<CR>", default_opt)
map(base_helper_key, "n", "<S-Right>", "<cmd>vertical resize +10<CR>", default_opt)
map(base_helper_key, "n", "<S-Down>", "<cmd>resize +10<CR>", default_opt)
map(base_helper_key, "n", "<S-Up>", "<cmd>resize -10<CR>", default_opt)

-- Tab
map(base_helper_key, "n", "t[", "<cmd>tabprevious<CR>", default_opt)
map(base_helper_key, "n", "t]", "<cmd>tabnext<CR>", default_opt)
map(base_helper_key, "n", "tn", "<cmd>tabnew<CR>", default_opt)
map(base_helper_key, "n", "td", "<cmd>tabclose<CR>", default_opt)

-- Buffer
map(base_helper_key, "n", "b[", "<cmd>bprevious<CR>", default_opt)
map(base_helper_key, "n", "b]", "<cmd>bnext<CR>", default_opt)
map(base_helper_key, "n", "bn", "<cmd>enew<CR>", default_opt)
map(base_helper_key, "n", "bd", "<cmd>bdelete<CR>", default_opt)

-- clear hight light
map(base_helper_key, "n", "<CR>", "<cmd>nohlsearch<CR>", default_opt)

-- Switch CWD to the directory of the open buffer
map(base_helper_key, "n", "cd", "<cmd>cd %:p:h<CR>:pwd<CR>", default_opt)
-- Switch CWD to the root directory
-- map(base_helper_key, "n", "cdr :execute 'cd '.FindRoot() <CR>:pwd<cr>", opt>
-- Switch CWD to the home directory
map(base_helper_key, "n", "cdh", "<cmd>cd $HOME<CR>:pwd<CR>", default_opt)

--------------------------------------------------------------------
local tree_helper_key = "e"
-- nvim-tree
group(tree_helper_key, "explorer (nvim-tree)")
map(tree_helper_key, "n", "e", "<cmd>NvimTreeToggle<CR>", { desc = "explorer (nvim-tree)",  noremap = true, silent = true})
pluginKeys.nvimTreeList = function (bufnr)
    local api = require('nvim-tree.api')
    local opts = function(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    local key_map = function(mode, key, cmd, cmd_string, desc)
      vim.keymap.set(mode, key, cmd, opts(desc))
      require("tools.whichkey").register(mode, vim.g.mapHelperleader .. tree_helper_key .. key, cmd_string, opts(desc))
    end
    -- BEGIN_DEFAULT_ON_ATTACH
    key_map('n', '<C-]>', api.tree.change_root_to_node,          '<cmd>lua require("nvim-tree.api").tree.change_root_to_node()<CR>',         'CD')
    key_map('n', '<C-e>', api.node.open.replace_tree_buffer,     '<cmd>lua require("nvim-tree.api").node.open.replace_tree_buffer()<CR>',    'Open: In Place')
    key_map('n', '<C-k>', api.node.show_info_popup,              '<cmd>lua require("nvim-tree.api").node.show_info_popup()<CR>',             'Info')
    key_map('n', '<C-r>', api.fs.rename_sub,                     '<cmd>lua require("nvim-tree.api").fs.rename_sub()<CR>',                    'Rename: Omit Filename')
    key_map('n', '<C-t>', api.node.open.tab,                     '<cmd>lua require("nvim-tree.api").node.open.tab()<CR>',                    'Open: New Tab')
    key_map('n', '<C-v>', api.node.open.vertical,                '<cmd>lua require("nvim-tree.api").node.open.vertical()<CR>',               'Open: Vertical Split')
    key_map('n', '<C-x>', api.node.open.horizontal,              '<cmd>lua require("nvim-tree.api").node.open.horizontal()<CR>',             'Open: Horizontal Split')
    key_map('n', '<BS>',  api.node.navigate.parent_close,        '<cmd>lua require("nvim-tree.api").node.navigate.parent_close()<CR>',       'Close Directory')
    key_map('n', '<CR>',  api.node.open.edit,                    '<cmd>lua require("nvim-tree.api").node.open.edit()<CR>',                   'Open')
    key_map('n', '<Tab>', api.node.open.preview,                 '<cmd>lua require("nvim-tree.api").node.open.preview()<CR>',                'Open Preview')
    --key_map('n', '>',     api.node.navigate.sibling.next,        '<cmd>lua require("nvim-tree.api").node.navigate.sibling.next()<CR>',       'Next Sibling')
    --key_map('n', '<',     api.node.navigate.sibling.prev,        '<cmd>lua require("nvim-tree.api").node.navigate.sibling.prev()<CR>',       'Previous Sibling')
    key_map('n', '.',     api.node.run.cmd,                      '<cmd>lua require("nvim-tree.api").node.run.cmd()<CR>',                     'Run Command')
    key_map('n', '-',     api.tree.change_root_to_parent,        '<cmd>lua require("nvim-tree.api").tree.change_root_to_parent()<CR>',       'Up')
    key_map('n', 'a',     api.fs.create,                         '<cmd>lua require("nvim-tree.api").fs.create()<CR>',                        'Create')
    key_map('n', 'bmv',   api.marks.bulk.move,                   '<cmd>lua require("nvim-tree.api").marks.bulk.move()<CR>',                  'Move Bookmarked')
    key_map('n', 'B',     api.tree.toggle_no_buffer_filter,      '<cmd>lua require("nvim-tree.api").tree.toggle_no_buffer_filter()<CR>',     'Toggle No Buffer')
    key_map('n', 'c',     api.fs.copy.node,                      '<cmd>lua require("nvim-tree.api").fs.copy.node()<CR>',                     'Copy')
    key_map('n', 'C',     api.tree.toggle_git_clean_filter,      '<cmd>lua require("nvim-tree.api").tree.toggle_git_clean_filter()<CR>',     'Toggle Git Clean')
    key_map('n', '[c',    api.node.navigate.git.prev,            '<cmd>lua require("nvim-tree.api").node.navigate.git.prev()<CR>',           'Prev Git')
    key_map('n', ']c',    api.node.navigate.git.next,            '<cmd>lua require("nvim-tree.api").node.navigate.git.next()<CR>',           'Next Git')
    key_map('n', 'd',     api.fs.remove,                         '<cmd>lua require("nvim-tree.api").fs.remove()<CR>',                        'Delete')
    key_map('n', 'D',     api.fs.trash,                          '<cmd>lua require("nvim-tree.api").fs.trash()<CR>',                         'Trash')
    key_map('n', 'E',     api.tree.expand_all,                   '<cmd>lua require("nvim-tree.api").tree.expand_all()<CR>',                  'Expand All')
    key_map('n', 'e',     api.fs.rename_basename,                '<cmd>lua require("nvim-tree.api").fs.rename_basename()<CR>',               'Rename: Basename')
    key_map('n', ']e',    api.node.navigate.diagnostics.next,    '<cmd>lua require("nvim-tree.api").node.navigate.diagnostics.next()<CR>',   'Next Diagnostic')
    key_map('n', '[e',    api.node.navigate.diagnostics.prev,    '<cmd>lua require("nvim-tree.api").node.navigate.diagnostics.prev()<CR>',   'Prev Diagnostic')
    key_map('n', 'F',     api.live_filter.clear,                 '<cmd>lua require("nvim-tree.api").live_filter.clear()<CR>',                'Clean Filter')
    key_map('n', 'f',     api.live_filter.start,                 '<cmd>lua require("nvim-tree.api").live_filter.start()<CR>',                'Filter')
    key_map('n', 'g?',    api.tree.toggle_help,                  '<cmd>lua require("nvim-tree.api").tree.toggle_help()<CR>',                 'Help')
    key_map('n', 'gy',    api.fs.copy.absolute_path,             '<cmd>lua require("nvim-tree.api").fs.copy.absolute_path()<CR>',            'Copy Absolute Path')
    key_map('n', 'H',     api.tree.toggle_hidden_filter,         '<cmd>lua require("nvim-tree.api").tree.toggle_hidden_filter()<CR>',        'Toggle Dotfiles')
    key_map('n', 'I',     api.tree.toggle_gitignore_filter,      '<cmd>lua require("nvim-tree.api").tree.toggle_gitignore_filter()<CR>',     'Toggle Git Ignore')
    key_map('n', 'J',     api.node.navigate.sibling.last,        '<cmd>lua require("nvim-tree.api").node.navigate.sibling.last()<CR>',       'Last Sibling')
    key_map('n', 'K',     api.node.navigate.sibling.first,       '<cmd>lua require("nvim-tree.api").node.navigate.sibling.first()<CR>',      'First Sibling')
    key_map('n', 'm',     api.marks.toggle,                      '<cmd>lua require("nvim-tree.api").marks.toggle()<CR>',                     'Toggle Bookmark')
    key_map('n', 'o',     api.node.open.edit,                    '<cmd>lua require("nvim-tree.api").node.open.edit()<CR>',                   'Open')
    key_map('n', 'O',     api.node.open.no_window_picker,        '<cmd>lua require("nvim-tree.api").node.open.no_window_picker()<CR>',       'Open: No Window Picker')
    key_map('n', 'p',     api.fs.paste,                          '<cmd>lua require("nvim-tree.api").fs.paste()<CR>',                         'Paste')
    key_map('n', 'P',     api.node.navigate.parent,              '<cmd>lua require("nvim-tree.api").node.navigate.parent()<CR>',             'Parent Directory')
    key_map('n', 'q',     api.tree.close,                        '<cmd>lua require("nvim-tree.api").tree.close()<CR>',                       'Close')
    key_map('n', 'r',     api.fs.rename,                         '<cmd>lua require("nvim-tree.api").fs.rename()<CR>',                        'Rename')
    key_map('n', 'R',     api.tree.reload,                       '<cmd>lua require("nvim-tree.api").tree.reload()<CR>',                      'Refresh')
    key_map('n', 's',     api.node.run.system,                   '<cmd>lua require("nvim-tree.api").node.run.system()<CR>',                  'Run System')
    key_map('n', 'S',     api.tree.search_node,                  '<cmd>lua require("nvim-tree.api").tree.search_node()<CR>',                 'Search')
    key_map('n', 'U',     api.tree.toggle_custom_filter,         '<cmd>lua require("nvim-tree.api").tree.toggle_custom_filter()<CR>',        'Toggle Hidden')
    key_map('n', 'W',     api.tree.collapse_all,                 '<cmd>lua require("nvim-tree.api").tree.collapse_all()<CR>',                'Collapse')
    key_map('n', 'x',     api.fs.cut,                            '<cmd>lua require("nvim-tree.api").fs.cut()<CR>',                           'Cut')
    key_map('n', 'y',     api.fs.copy.filename,                  '<cmd>lua require("nvim-tree.api").fs.copy.filename()<CR>',                 'Copy Name')
    key_map('n', 'Y',     api.fs.copy.relative_path,             '<cmd>lua require("nvim-tree.api").fs.copy.relative_path()<CR>',            'Copy Relative Path')
    key_map('n', '<2-LeftMouse>',  api.node.open.edit,           '<cmd>lua require("nvim-tree.api").node.open.edit()<CR>',                   'Open')
    key_map('n', '<2-RightMouse>', api.tree.change_root_to_node, '<cmd>lua require("nvim-tree.api").tree.change_root_to_node()<CR>',         'CD')
end

--------------------------------------------------------------------
-- Telescope
local finder_helper_key = "f"
group(finder_helper_key, "finder (telescope)")
-- don't need to append finder_helper_key, because all key_map begin with "f"
-- if you do it, your helper key will be like this "\fff"...
map("", "n", "ff", "<cmd>lua require('ui.telescope').launch_find_files()<CR>", default_opt)
map("", 'n', 'fg', "<cmd>lua require('ui.telescope').launch_live_grep()<CR>", default_opt)
map("", 'n', 'fb', "<cmd>Telescope buffers<CR>", default_opt)
map("", 'n', 'fh', "<cmd>Telescope help_tags<CR>", default_opt)
map("", 'n', 'fe', "<cmd>Telescope env<CR>", default_opt)
map("", 'n', 'fc', "<cmd>Telescope commands<CR>", default_opt)
map("", 'n', 'fs', "<cmd>Telescope grep_string<CR>", default_opt)
map("", 'n', 'fp', "<cmd>Telescope projects<CR>", default_opt)
map("", 'n', 'fo', "<cmd>Telescope oldfiles<CR>", default_opt)
map("", 'n', 'fk', "<cmd>Telescope keymaps<CR>", default_opt)
pluginKeys.telescopeList = {
  i = {
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<C-v>"] = "select_horizontal",
    ["<C-h>"] = "select_vertical",
    ["<C-u>"] = "results_scrolling_up",
    ["<C-d>"] = "results_scrolling_down",
    ["<C-b>"] = "preview_scrolling_up",
    ["<C-f>"] = "preview_scrolling_down",
    ["<Down>"] = "cycle_history_next",
    ["<Up>"] = "cycle_history_prev",
    ["<esc>"] = "close",
  },
}

--------------------------------------------------------------------
local code_assistant_helper_key = "a"
group(code_assistant_helper_key, "code assistant")
-- Comment
pluginKeys.comment = {
  toggler = {
    line = "cc",
  },
  opleader = {
    block = "cb",
  },
}
group(code_assistant_helper_key .. "c", "comment code")
map(code_assistant_helper_key .. "c", "n", "c", "cc", { desc = "comment code", noremap = false })
map(code_assistant_helper_key .. "c", "v", "c", "cb", { desc = "comment code", noremap = false })

-- treesitter code fold
group(code_assistant_helper_key .. "z", "fold code")
map(code_assistant_helper_key .. "z", "n", "z", "<cmd>foldclose<CR>", default_opt)
map(code_assistant_helper_key .. "zz", "n", "zz", "<cmd>foldopen<CR>", default_opt)

--------------------------------------------------------------------
-- lsp keybindings in callback function
pluginKeys.mapLSP = function(mapbuf)
  local lsp_helper_key = "l"
  group(lsp_helper_key, "lsp")

  local opts = function(desc)
    return { desc = 'lsp: ' .. desc, noremap = true, silent = true, nowait = true }
  end
  local key_map = function(mode, key, cmd, desc)
    mapbuf(mode, "<leader>".. lsp_helper_key .. key, cmd, opts(desc))
    require("tools.whichkey").register(mode, vim.g.mapHelperleader .. lsp_helper_key .. key, cmd, opts(desc))
  end

  if G.lsp_ui then
    -- rename
    key_map("n", "n", "<cmd>Lspsaga rename<CR>", "rename")
    key_map("n", "a", "<cmd>Lspsaga code_action<CR>", "code_action")
    key_map('n', 'd', '<cmd>Lspsaga goto_definition<CR>', "goto_definition")
    key_map('n', 'p', '<cmd>Lspsaga peek_definition<CR>', "peek_definition")
    key_map("n", "h", "<cmd>Lspsaga hover_doc<cr>", "hover_doc")
    key_map("n", "r", "<cmd>Lspsaga lsp_finder<CR>", "lsp_finder")
    --key_map("n", "d", "<cmd>Lspsaga show_line_diagnostics<CR>", "show_line_diagnostics")
    key_map("n", "]", "<cmd>Lspsaga diagnostic_jump_next<cr>", "diagnostic_jump_next")
    key_map("n", "[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "diagnostic_jump_prev")
    key_map("n", "i", "<cmd>Lspsaga incoming_calls<CR>", "incoming_calls")
    key_map("n", "o", "<cmd>Lspsaga outgoing_calls<CR>", "outgoing_calls")
    key_map("n", "t", "<cmd>Lspsaga term_toggle<CR>", "term_toggle")
    key_map("t", "t", "<cmd>Lspsaga term_toggle<CR>", "term_toggle")
  else
    key_map("n", "n", "<cmd>lua vim.lsp.buf.rename()<CR>", "rename")
    key_map("n", "a", "<cmd>lua vim.lsp.buf.code_action()<CR>", "code_action")
    key_map("n", "d", "<cmd>lua vim.lsp.buf.definition()<CR>", "definition")
    key_map("n", "h", "<cmd>lua vim.lsp.buf.hover()<CR>", "hover")
    key_map("n", "r", "<cmd>lua vim.lsp.buf.references()<CR>", "references")
    key_map("n", "d", "<cmd>lua vim.diagnostic.open_float()<CR>", "open_float")
    key_map("n", "]", "<cmd>lua vim.diagnostic.goto_next()<CR>", "goto_next")
    key_map("n", "[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "goto_prev")
    -- key_map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opt)
    -- 未用
    -- key_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
    -- key_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
    -- key_map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
    -- key_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
    -- key_map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
    -- key_map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
    -- key_map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
    -- key_map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
  end
  key_map("n", "d", "<cmd>Telescope diagnostics<CR>", "diagnostics")
end

-- vimspector
pluginKeys.mapVimspector = function()
  -- 开始
  --map("n", "<leader>dl", "<cmd>call vimspector#Launch()<CR>", opt)
  ---- 结束
  --map("n", "<Leader>dr", "<cmd>call vimspector#Reset()<CR>", opt)
  ---- 继续
  --map("n", "<Leader>dc", "<cmd>call vimspector#Continue()<CR>", opt)
  ---- 设置断点
  --map("n", "<Leader>db", "<cmd>call vimspector#ToggleBreakpoint()<CR>", opt)
  --map("n", "<Leader>dT", "<cmd>call vimspector#ClearBreakpoints()<CR>", opt)
  ----  stepOver, stepOut, stepInto
  --map("n", "<leader>dj", "<Plug>VimspectorStepOver", opt)
  --map("n", "<leader>dk", "<Plug>VimspectorStepOut", opt)
  --map("n", "<leader>dl", "<Plug>VimspectorStepInto", opt)
end

-- nvim-cmp
pluginKeys.cmp = function(cmp)
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<A-,>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- scroll
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs( -4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    -- snippets jump
    ["<C-l>"] = cmp.mapping(function(_)
      if vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if vim.fn["vsnip#jumpable"]( -1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    -- super Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"]( -1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    -- end of super Tab
  }
end


-- toggleterm
-- <leader>tf float window; <leader>tl left window; <leader>tj bottem window
pluginKeys.mapToggleTerm = function(toggleterm)
--  vim.keymap.set({ "n", "t" }, "<leader>tt", toggleterm.toggleJ)
end

-- hop (move cursor)
--map("n", "mj", "<cmd>HopLineBC<CR>", default_opt)
--map("v", "mj", "<cmd>HopLineBC<CR>", default_opt)
--map("n", "mk", "<cmd>HopLineAC<CR>", default_opt)
--map("v", "mk", "<cmd>HopLineAC<CR>", default_opt)
--map("n", "mh", "<cmd>HopWordCurrentLineBC<CR>", default_opt)
--map("v", "mh", "<cmd>HopWordCurrentLineBC<CR>", default_opt)
--map("n", "ml", "<cmd>HopWordCurrentLineAC<CR>", default_opt)
--map("v", "ml", "<cmd>HopWordCurrentLineAC<CR>", default_opt)

return pluginKeys
