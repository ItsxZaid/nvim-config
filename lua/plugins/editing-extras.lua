return {

  {

    'numToStr/Comment.nvim',

    config = function()

      require('Comment').setup()

    end,

  },


  {

    'windwp/nvim-autopairs',

    event = "InsertEnter", -- 

    config = function()

      require('nvim-autopairs').setup()

      -- We'll add a keymap for this later

    end,

  },

}
