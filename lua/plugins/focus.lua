return {
  {
    "nvim-focus/focus.nvim",
    version = "*",
    event = "WinEnter",
    opts = {
      enable = true,
      -- Auto-resize disabled — splits stay at fixed sizes
      autoresize = {
        enable = false,
      },
      ui = {
        -- Dim inactive windows
        number = false,       -- don't change number style in inactive windows
        relativenumber = false,
        hybridnumber = false,
        absolutenumber_unfocused = false,
        cursorline = true,    -- keep cursorline only in active window
        cursorcolumn = false,
        colorcolumn = {
          enable = false,
        },
        signcolumn = true,
        winhighlight = true,  -- this is what triggers the dimming
      },
    },
    config = function(_, opts)
      require("focus").setup(opts)

      -- Toggle focus dimming on/off
      vim.keymap.set("n", "<leader>uF", "<cmd>FocusToggle<cr>", { desc = "Toggle Focus Dimming" })
    end,
  },
}
