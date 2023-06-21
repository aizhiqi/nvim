-- plugin path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  vim.notify("lazy.nvim is installed!")
end
vim.opt.rtp:prepend(lazypath)

--  a protected call so we don't error out on first 
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  error("can't find lazy.nvim")
end

local plugins = {
  -- lazy can update self
  "folke/lazy.nvim",
  -------------------------- plugins -------------------------------------------
  ----------------------- colorschemes --------------------
  -- tokyonight
  "folke/tokyonight.nvim",

  ----------------------- uicomponents --------------------
  -- nvim-tree (directory tree)
  {"nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons", },
  -- lualine (status bar)
  {"nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, },
  "arkav/lualine-lsp-progress",
  -- telescope (searcher)
  {"nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, },
  "LinArcX/telescope-env.nvim",
  "ahmedkhalf/project.nvim",
  -- messages, cmdline and the popupmenu
  -- {"folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}, },

  -------------- code analyze and highlight ---------------
  -- treesitter ()
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", },
  -- indent-blankline
  "lukas-reineke/indent-blankline.nvim",
  -- nvim-autopairs
  "windwp/nvim-autopairs",
  -- comment
  "numToStr/Comment.nvim",
  -- formatter
  --("mhartington/formatter.nvim")

  -------------------------- LSP --------------------------
  -- LSP Installer
  {"williamboman/mason.nvim" },
  {"williamboman/mason-lspconfig.nvim" },
  {"neovim/nvim-lspconfig" },
  -- autocomplete engine
  "hrsh7th/nvim-cmp",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "rafamadriz/friendly-snippets",
  -- Lua nvim code assistant
  "folke/neodev.nvim",
  -- JSON assistant
  "b0o/schemastore.nvim",
  -- Rust assistant
  "simrat39/rust-tools.nvim",
  -- flutter
  {'akinsho/flutter-tools.nvim',
   dependencies = {
       'nvim-lua/plenary.nvim',
       'stevearc/dressing.nvim', -- optional for vim.ui.select
   },},

  ------------------------- Tools -------------------------
  -- git
  "lewis6991/gitsigns.nvim",
  -- toggle term
  {"phaazon/hop.nvim", branch = "v2" },
  "akinsho/toggleterm.nvim",
  -- key
  "folke/which-key.nvim",

  ---------------------- debugger -------------------------
  ---- vimspector
  "puremourning/vimspector",
}

if G.colorscheme then
  --colorscheme
  table.insert(plugins, {
  -- OceanicNext
  "mhartington/oceanic-next",
  -- nord
  "shaunsingh/nord.nvim",
  -- onedark
  "ful1e5/onedark.nvim",
  -- nightfox
  "EdenEast/nightfox.nvim",
  })
end

if G.lsp_ui then
    ---- UI for lsp
  table.insert(plugins, {
    "simrat39/symbols-outline.nvim",
    "onsails/lspkind-nvim",
    {
      "glepnir/lspsaga.nvim",
      dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        --Please make sure you install markdown and markdown_inline parser
        { "nvim-treesitter/nvim-treesitter" } }
    },
    -- showing diagnostics, references, telescope results, quickfix and location lists
    "folke/trouble.nvim",
  })
end

lazy.setup(plugins)
