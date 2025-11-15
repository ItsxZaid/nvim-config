return {

 'akinsho/toggleterm.nvim',

  version = "*", -- Use the latest stable version

  config = function()

    require('toggleterm').setup {

      -- set the size of the floating terminal

      size = 20,

      open_mapping = [[<c-\>]], -- A default map, but we use our own in keymaps.lua

      hide_numbers = true, -- Hide line numbers in terminal buffers

      shade_terminals = true,

      shading_factor = 2, -- How dark to shade the terminal

      start_in_insert = true, -- Start in insert mode

      insert_mappings = true, -- Allow insert mode mappings

      persist_size = true,

      direction = 'float', -- Default to floating

      close_on_exit = true, -- Close the terminal window when the process exits

    }

  end,

}
