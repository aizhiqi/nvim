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

local opt = {
  noremap = true,
  silent = true,
}

-- define map function
local map = vim.api.nvim_set_keymap

--------------------------------------------------------------------
-- quit
map("n", "<leader>q", ":q<CR>", opt)
map("n", "<leader>w", ":w<CR>", opt)

-- don't copy text in visual mode after paste
map("v", "p", '"_dP', opt)

-- <leader> + hjkl switch window
map("n", "<leader>h", "<C-w>h", opt)
map("n", "<leader>j", "<C-w>j", opt)
map("n", "<leader>k", "<C-w>k", opt)
map("n", "<leader>l", "<C-w>l", opt)

-- adjust window size
map("n", "<leader><S-Left>", ":vertical resize -10<CR>", opt)
map("n", "<leader><S-Right>", ":vertical resize +10<CR>", opt)
map("n", "<leader><S-Down>", ":resize +10<CR>", opt)
map("n", "<leader><S-Up>", ":resize -10<CR>", opt)

-- Tab
map("n", "<leader>th", ":tabprevious<CR>", opt)
map("n", "<leader>tl", ":tabnext<CR>", opt)
map("n", "<leader>tn", ":tabnew<CR>", opt)
map("n", "<leader>td", ":tabclose<CR>", opt)

-- Buffer
map("n", "<leader>bh", ":bprevious<CR>", opt)
map("n", "<leader>bl", ":bnext<CR>", opt)
map("n", "<leader>bn", ":badd", opt)
map("n", "<leader>bd", ":bdelete<CR>", opt)

-- clear hight light
map("n", "<leader><CR>", ":nohlsearch<CR>", opt)

-- Switch CWD to the directory of the open buffer
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", opt)
-- Switch CWD to the root directory
-- map("n", "<Leader>cdr :execute 'cd '.FindRoot() <CR>:pwd<cr>", opt>
-- Switch CWD to the home directory
map("n", "<leader>cdh", ":cd $HOME<CR>:pwd<CR>", opt)

--------------------------------------------------------------------
-- keybindings for plugin
local pluginKeys = {}

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)
pluginKeys.nvimTreeList = {
  -- open item
  { key = { "o", "<2-LeftMouse>" }, action = "edit" },
  { key = "vs", action = "vsplit" },
  { key = "sp", action = "split" },
  { key = "i", action = "toggle_ignored" },
  { key = ".", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  -- file operation
  { key = "n", action = "create" },
  { key = "d", action = "remove" },
  { key = "m", action = "rename" },
  { key = "x", action = "cut" },
  { key = "y", action = "copy" },
  { key = "p", action = "paste" },
  { key = "cp", action = "copy_absolute_path" },
  -- enter sub directory
  { key = { "]" }, action = "cd" },
  -- enter parent directory
  { key = { "[" }, action = "dir_up" },
}

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opt)
map('n', '<leader>fg', ":Telescope live_grep<CR>", opt)
map('n', '<leader>fb', ":Telescope buffers<CR>", opt)
map('n', '<leader>fh', ":Telescope help_tags<CR>", opt)
map('n', '<leader>fe', ":Telescope env<CR>", opt)
map('n', '<leader>fc', ":Telescope commands<CR>", opt)
map('n', '<leader>fs', ":Telescope grep_string<CR>", opt)
map('n', '<leader>fp', ":Telescope projects<CR>", opt)
map('n', '<leader>fo', ":Telescope oldfiles<CR>", opt)
map('n', '<leader>fk', ":Telescope keymaps<CR>", opt)
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

-- Comment
pluginKeys.comment = {
  toggler = {
    line = "cc",
  },
  opleader = {
    block = "cb",
  },
}
map("n", "cc", "cc", { noremap = false })
map("v", "cc", "cb", { noremap = false })

-- treesitter code fold
map("n", "zz", ":foldclose<CR>", opt)
map("n", "Z", ":foldopen<CR>", opt)

-- lsp keybindings in callback function
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  -- Lspsaga or lsp
  mapbuf("n", "rn", "<cmd>Lspsaga rename<CR>", opt)
  -- mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)

  -- code action
  mapbuf("n", "ca", "<cmd>Lspsaga code_action<CR>", opt)
  -- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)

  -- go xx
  mapbuf('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opt)
  -- mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  -- mapbuf("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions({ initial_mode = 'normal', })<CR>", opt)

  mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
  -- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)

  -- mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)

  -- diagnostic
  --[[
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  --]]
  mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
  mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
  -- mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opt)
  -- 未用
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- vimspector
pluginKeys.mapVimspector = function()
  -- 开始
  map("n", "<leader>dd", ":call vimspector#Launch()<CR>", opt)
  -- 结束
  map("n", "<Leader>de", ":call vimspector#Reset()<CR>", opt)
  -- 继续
  map("n", "<Leader>dc", ":call vimspector#Continue()<CR>", opt)
  -- 设置断点
  map("n", "<Leader>dt", ":call vimspector#ToggleBreakpoint()<CR>", opt)
  map("n", "<Leader>dT", ":call vimspector#ClearBreakpoints()<CR>", opt)
  --  stepOver, stepOut, stepInto
  map("n", "<leader>dj", "<Plug>VimspectorStepOver", opt)
  map("n", "<leader>dk", "<Plug>VimspectorStepOut", opt)
  map("n", "<leader>dl", "<Plug>VimspectorStepInto", opt)
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
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    -- snippets jump
    ["<C-l>"] = cmp.mapping(function(_)
      if vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if vim.fn["vsnip#jumpable"](-1) == 1 then
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
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    -- end of super Tab
  }
end


-- toggleterm 
-- <leader>tf float window; <leader>tl left window; <leader>tj bottem window 
pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ "n", "t" }, "<leader>tf", toggleterm.toggleF)
  vim.keymap.set({ "n", "t" }, "<leader>tl", toggleterm.toggleL)
  vim.keymap.set({ "n", "t" }, "<leader>tj", toggleterm.toggleJ)
end

return pluginKeys
