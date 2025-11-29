return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      -- LazyVim config for treesitter
      indent = { enable = true }, ---@type lazyvim.TSFeat
      highlight = { enable = true }, ---@type lazyvim.TSFeat
      folds = { enable = true }, ---@type lazyvim.TSFeat
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "toml",
        "tsx",
        "xml",
        "yaml"
      },
    },
  }
}
