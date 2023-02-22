-- plugin path
-- ~/.local/share/nvim/site/pack/packer/
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.notify("Installing Pakcer.nvim...")
  paccker_bootstrap = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim is installed!")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("can't find packer.nvim")
  return
end

packer.startup({
  function(use)
    -- Packer can update self 
    use("wbthomason/packer.nvim")
    -------------------------- plugins -------------------------------------------
    ----------------------- colorschemes --------------------
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- OceanicNext
    use("mhartington/oceanic-next")
    -- nord
    use("shaunsingh/nord.nvim")
    -- onedark
    use("ful1e5/onedark.nvim")
    -- nightfox
    use("EdenEast/nightfox.nvim")
    ----------------------- uicomponents --------------------
    -- nvim-tree (directory tree)
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons", })
    -- lualine (status bar)
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" }, })
    use("arkav/lualine-lsp-progress")
    -- telescope (searcher)
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" }, })
    use("LinArcX/telescope-env.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    use("ahmedkhalf/project.nvim") --need bugfix
    -------------- code analyze and highlight ---------------
    -- treesitter ()
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", })
    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")
    -- nvim-autopairs
    use("windwp/nvim-autopairs")
    -- comment
    use("numToStr/Comment.nvim")
    -- formatter
    --use("mhartington/formatter.nvim")
    -------------------------- LSP --------------------------
    -- LSP Installer
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "neovim/nvim-lspconfig" })
    -- autocomplete engine
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
    use("rafamadriz/friendly-snippets")

if G.lsp_ui then
    ---- UI for lsp
    use("onsails/lspkind-nvim")
    use("tami5/lspsaga.nvim")
end

    -- Lua nvim code assistant
    use("folke/neodev.nvim")
    -- JSON assistant
    use("b0o/schemastore.nvim")
    -- Rust assistant
    use("simrat39/rust-tools.nvim")

    ------------------------- Tools -------------------------
    -- git
    use({ "lewis6991/gitsigns.nvim" })
    -- toggle term
    use { "phaazon/hop.nvim", branch = "v2"}
    use({ "akinsho/toggleterm.nvim" })

    ---------------------- debugger -------------------------
    ---- vimspector
    use("puremourning/vimspector")
    -------------------------- plugins -------------------------------------------

    if paccker_bootstrap then
      packer.sync()
    end
  end,
  config = {
    -- snapshots path
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- plugins won't been update(always v1), if this option is set
    -- snapshot = "v1",

    -- jobs count
    max_jobs = 16,
    -- other sources
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    display = {
      -- use float window
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})


