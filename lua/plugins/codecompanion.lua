return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    -- Added mini.nvim because you configured 'mini_diff' below
    "nvim-mini/mini.nvim", 
  },
  keys = {
    { "<leader>ia", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
    { "<leader>ii", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "AI Inline Assistant" },
  },
  config = function()
    require("codecompanion").setup({
      commands = {
        default = {
          "--experimental-acp",
        },
      },
      adapters = {
        acp = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              auth_method = "oauth-personal",
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = acp },
        inline = { adapter = acp },
        agent = { adapter = acp },
      },
    })
  end,
}