return {

  {

    'nvim-lualine/lualine.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()

      require('lualine').setup({

        options = {

          theme = 'auto', 

          component_separators = { left = '', right = '' },

          section_separators = { left = '', right = '' },

        },

        sections = {

          lualine_c = { 'filename' },

          lualine_x = { 'filetype' },

          lualine_y = { 'progress' },

          lualine_z = { 'location' },

        },

      })

    end,

  },


  {

    "lukas-reineke/indent-blankline.nvim",

    main = "ibl",

    config = function()

      require("ibl").setup({

        scope = { enabled = true, show_start = false, show_end = false },

      })

    end

  },

}
