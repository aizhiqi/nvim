-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
-- ensure 8 line can be see when use jkhl
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- don't use relativenumber
vim.wo.number = true
vim.wo.relativenumber = false
-- highlight current line
vim.wo.cursorline = true
-- show left icon column
vim.wo.signcolumn = "yes"
-- don't show right vertical line (remind wrap line)
vim.wo.colorcolumn = "0"
-- 1 Tab = 2 bank
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- move lenght when use >> <<
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- use bank insted of tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- auto indent the line above
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- ignore case when search
vim.o.ignorecase = true
vim.o.smartcase = true
-- hight light search result
vim.o.hlsearch = true
-- show search result when input not completly
vim.o.incsearch = true
-- hight for command line
vim.o.cmdheight = 1
-- auto reload when file modified outside
vim.o.autoread = true
vim.bo.autoread = true
-- disable wrap line
vim.wo.wrap = false
-- cusor auto step to another line use <Left><Right> to line of end
vim.o.whichwrap = "<,>,[,]"
-- buffer can be hidden
vim.o.hidden = true
-- enable mouse in vim
vim.o.mouse = "a"
-- don't create swap file
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- the time for two key down comebine to one command
-- https://github.com/nshen/learn-neovim-lua/issues/1
vim.o.timeoutlen = 500
-- split window positon
vim.o.splitbelow = true
vim.o.splitright = true
-- don't auto select the 1st item when snippet window is showing
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- style
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- don't show unvisiable char
vim.o.list = false
-- show bank to .
vim.o.listchars = "space:·,tab:··"
-- for auto completly
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"
-- the max item count in complete window
vim.o.pumheight = 10
-- show tabline
vim.o.showtabline = 1
-- use 3rd statusbar, disable naitive tips
vim.o.showmode = false
-- use systemc clipboard
vim.opt.clipboard = "unnamedplus"
