return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),

        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["jk"] = cmp.mapping.abort(),
          ["kj"] = cmp.mapping.abort(),
        }),

        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = require("lspkind").cmp_format({
            with_text = true,
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              path = "[Path]",
            },
          }),
        },
      })
    end,
  },

  {
    "onsails/lspkind.nvim",
  },
}
