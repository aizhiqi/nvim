local status, cmp = pcall(require, "cmp")
if not status then
  vim.notify("can't find cmp")
  return
end

local formatting
if G.lsp_ui then
  formatting = require("lsp.ui").formatting
else
  formatting = {
    format = function(entry, vim_item)
      if not G.lsp_ui then
        -- Kind 
        vim_item.kind = string.format('%s', vim_item.kind)
        -- Source
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        -- Width
        vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
        return vim_item
      end
    end
  }
end

cmp.setup({
  -- config engine for snippet
  snippet = {
    expand = function(args)
      -- For `vsnip` users.
      vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` users.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` users.
      -- vim.fn["UltiSnips#Anon"](args.body)

      -- For `snippy` users.
      -- require'snippy'.expand_snippet(args.body)
    end,
  },
  -- source
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    -- For vsnip users.
    { name = "vsnip" },
    { name = "buffer" },
    -- For luasnip users.
    -- { name = 'luasnip' },
    --For ultisnips users.
    -- { name = 'ultisnips' },
    -- -- For snippy users.
    -- { name = 'snippy' },
  }, { { name = "path" } }),

  -- key mapping
  mapping = require("keybindings").cmp(cmp),

  -- show icon use lspkind-nvim
  formatting = formatting,
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
