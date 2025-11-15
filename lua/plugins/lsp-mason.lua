return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Go to Definition
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- Go to Declaration
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        -- Hover for documentation
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- Find References
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- Rename symbol
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        -- Diagnostics
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
      end

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "ts_ls",
          "cssls",
          "html",
          "jsonls",
          "tailwindcss",
        },
        automatic_installation = true,

        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
            })
          end,
        }
      })
    end,
  },
}
