return {
  {	
    "rebelot/kanagawa.nvim",
    -- Set priority to ensure it loads early, before other plugins try to use it
    priority = 1000,
    -- Load the plugin eagerly (lazy = false) since it's a colorscheme
    lazy = false,
    -- The config function is where you set options for the theme itself
    config = function()
      require("kanagawa").setup({
        -- You can customize any of the Kanagawa options here.
        -- For example, to use the 'dragon' theme variant by default:
        theme = "dragon",
        transparent = false, -- Set to true if you want a transparent background
        compile = false,     -- Set to true for a slight speed-up after initial compile
        undercurl = true,
        commentStyle = { italic = true },
      -- Add other custom overrides here, like changing specific colors
      -- overrides = function(colors)
      --   return {
      --     Comment = { fg = colors.palette.waveRed },
      --   }
      -- end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- Set this to the base colorscheme name from the plugin
      -- Note: Kanagawa.nvim provides sub-themes like `kanagawa-wave`, `kanagawa-dragon`, etc.,
      -- but the base name is often enough for LazyVim's default setting.
      -- If you want to use a specific variant, use the full name:
      colorscheme = "kanagawa-dragon",
    },
  },
}
