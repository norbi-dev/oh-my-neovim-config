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
      adapters = {
        gemini_cli = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              defaults = {
                auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = "gemini_cli" },
        inline = { adapter = "gemini_cli" },
        agent = { adapter = "gemini_cli" },
      },
    })
  end,
}