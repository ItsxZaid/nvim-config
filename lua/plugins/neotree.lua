return {
  "nvim-neo-tree/neo-tree.nvim",

  branch = "v3.x",

  dependencies = {

    "nvim-lua/plenary.nvim",

    "MunifTanjim/nui.nvim",

    "nvim-tree/nvim-web-devicons",

  },

  lazy = false, -- We keep this false so the keymap works on startup

  config = function()

    require("neo-tree").setup({

      window = {

        position = "left",

        width = 30, 
      },

      -- This will close Neo-tree if it is the last window left

      close_if_last_window = true,

      

      filesystem = {

        -- This makes it so opening a directory just opens neo-tree

        hijack_netrw_behavior = "open_current_dir",

        -- This will make the tree follow you as you change buffers

        follow_current_file = {

          enabled = true,

          leave_dirs_open = true,

        },

        -- Show git status icons

        git_status_colors = true,

      },

      -- Add git status integration

      source_selector = {

        winbar = true, -- Puts tabs at the top of the tree

        sources = {

          { source = "filesystem" },

          { source = "git_status" },

        },

      },

      -- Sane defaults

      default_component_configs = {

        indent = {

          with_expanders = true, -- Show + and - icons

          expander_collapsed = "",

          expander_expanded = "",

          expander_highlight = "NeoTreeExpander",

        },

        icon = {

          default = "󰈚",

          foler_closed = "",

          folder_open = "",

        },

        git_status = {

          symbols = {

            added = "A",

            modified = "M",

            deleted = "D",

            renamed = "R",

            untracked = "U",

            ignored = "I",

            conflicted = "C",

          },

        },

      },

    })




    -- We create an autocommand that listens for when you
    -- leave the 'lazygit' buffer and then tells neo-tree
    -- to refresh its Git status.
    --
    local augroup = vim.api.nvim_create_augroup("NeoTreeGitRefresh", { clear = true })
    vim.api.nvim_create_autocmd({ "BufLeave" }, {
      group = augroup,
      pattern = "lazygit",     
        callback = function()
        local events = require("neo-tree.events")
        events.fire_event(events.GIT_EVENT)
      end,
    })

  end,

}
