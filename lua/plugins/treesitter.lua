return {

  'nvim-treesitter/nvim-treesitter',

  build = ':TSUpdate', 

  config = function()

    require('nvim-treesitter.configs').setup({

      -- A list of parser names, or "all"

      ensure_installed = { "lua", "vim", "javascript", "typescript", "json", "css", "html" },


      -- Install parsers synchronously (only relevant for :TSUpdate)

      sync_install = false,


      -- Automatically install missing parsers when entering a buffer

      auto_install = true,


      -- Enable syntax-based highlighting

      highlight = {

        enable = true,

      },


      -- Enable indentation based on treesitter

      indent = {

        enable = true,

      },

    })

  end,

}
