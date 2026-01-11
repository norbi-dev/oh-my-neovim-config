return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  -- Define global keymaps here (Lazy loads the plugin when these are pressed)
  keys = {
    { "<leader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat Toggle" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "AI Inline" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add Visual Selection to Chat" },
  },
  config = function()
    require("codecompanion").setup({
      -- 1. Set the strategies to use the gemini_cli adapter
      strategies = {
        chat = {
          adapter = "gemini_cli",
          -- Custom Keymaps INSIDE the Chat Buffer
          keymaps = {
            send = {
              modes = { n = "<CR>", i = "<C-CR>" }, -- Press Ctrl+Enter in Insert mode to send
            },
            close = {
              modes = { n = "q" },
            },
            -- Add other buffer-specific maps here
          },
        },
        inline = {
          adapter = "gemini_cli",
        },
        agent = {
          adapter = "gemini_cli",
        },
      },

      -- 2. Optional: Customize the adapter (if you need specific flags/env vars)
      adapters = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            env = {
              -- If you need to explicitly set the API key here instead of system env
              -- GEMINI_API_KEY = "YOUR_KEY_HERE" 
            },
            commands = {
              default = {
                "--experimental-acp",
              },
            },
            defaults = {
              auth_method = "oauth-personal",
            },
            -- Ensure the command points to the correct binary if not in PATH
            -- command = "gemini", 
          })
        end,
      },
    })
  end,
}