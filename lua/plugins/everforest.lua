return {
  {
    "sainnhe/everforest",
    -- Load eagerly before other plugins since it's a colorscheme
    priority = 1000,
    lazy = false,
    config = function()
      -- everforest uses vim globals, not a Lua setup() call
      vim.opt.background = "dark"

      -- Contrast level: 'hard', 'medium' (default), or 'soft'
      vim.g.everforest_background = "medium"

      -- Enable italics (requires an italic-capable font/terminal)
      vim.g.everforest_enable_italic = true

      -- Better performance (loads highlight groups on demand)
      vim.g.everforest_better_performance = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
