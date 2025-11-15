return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.9',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          -- JS / TS
          "node_modules",
          "dist",
          "build",
          "%.min%.js",
          "%.min%.css",
          "package%-lock%.json",
          "yarn%.lock",
          "pnpm%-lock%.yaml",

          -- Svelte / Frontend
          "%.svelte",
          "%.astro",
          "%.vue",

          -- Rust
          "target",
          "%.rs.bk",

          -- Go
          "bin/",
          "pkg/",
          "%.test",

          -- Python (just in case)
          "__pycache__",
          "%.pyc",

          -- Git / general
          "%.git",
          "lazy%-lock%.json",
          "%.DS_Store",

          -- Coverage / cache
          "coverage",
          "%.coverage",
          "%.nyc_output",
          "%.cache",
        },

        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
      },
    })
  end,
}
