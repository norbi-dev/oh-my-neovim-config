return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: for autocomplete integration
  },
  keys = {
    { "<leader>ic", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat" },
    { "<leader>ia", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
    { "<leader>ii", "<cmd>CodeCompanion<cr>", desc = "AI Inline" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to AI Chat" },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
          roles = { llm = "Agent", user = "Me" },
          slash_commands = {
            ["file"] = {
              callback = "strategies.chat.slash_commands.file",
              description = "Select a file to search and read",
              opts = { contains_code = true },
            },
            ["buffer"] = {
              callback = "strategies.chat.slash_commands.buffer",
              description = "Insert the current buffer content",
              opts = { contains_code = true },
            },
          },
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen2.5-coder:7b", -- 7b is MUCH better for "Agent" tasks like unit tests
              },
              num_ctx = {
                default = 8192, -- Increased context for reading larger files
              },
            },
          })
        end,
      },
    })
  end,
}