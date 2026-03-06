return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 0.90, -- dim the area outside zen window (1 = no dimming)
        width = 100,     -- width of the zen window
        height = 1,      -- 1 = full height
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          foldcolumn = "0",
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0, -- hide statusline
        },
        twilight = { enabled = false }, -- dim inactive code (requires folke/twilight.nvim)
        gitsigns = { enabled = false }, -- hide git signs in the gutter
        tmux = { enabled = false },
      },
    },
  },
}
