return {

  "folke/which-key.nvim",

  event = "VeryLazy",

  config = function()

    require("which-key").setup({

      timeoutlen = 300,

    })

  end,

}
