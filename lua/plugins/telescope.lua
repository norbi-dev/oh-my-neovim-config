return {
  -- LazyVim already manages telescope with lazy loading and keymaps.
  -- Only add overrides here if needed.
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
