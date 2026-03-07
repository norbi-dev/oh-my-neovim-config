return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Render markdown nicely in the chat buffer
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionActions",
    },
    keys = {
      { "<C-a>",        "<cmd>CodeCompanionActions<cr>",      mode = { "n", "v" }, desc = "CodeCompanion Actions" },
      { "<leader>ac",   "<cmd>CodeCompanionChat Toggle<cr>",  mode = { "n", "v" }, desc = "Toggle Chat" },
      { "<leader>ai",   "<cmd>CodeCompanion<cr>",             mode = { "n", "v" }, desc = "Inline Assistant" },
      { "ga",           "<cmd>CodeCompanionChat Add<cr>",     mode = "v",          desc = "Add selection to chat" },
    },
    opts = {
      -- ── Adapters ──────────────────────────────────────────────────────────
      adapters = {
        -- Ollama local adapter — used for lightweight inline autocomplete
        ollama_coder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama_coder",
            schema = {
              model = {
                default = "qwen2.5-coder:1.5b",
              },
              -- Keep responses fast for inline use
              num_ctx = {
                default = 4096,
              },
              temperature = {
                default = 0.1,
              },
            },
          })
        end,
      },

      -- ── Interactions ──────────────────────────────────────────────────────
      interactions = {
        -- Chat & agentic work → OpenCode ACP adapter
        -- Reads model from ~/.config/opencode/config.json automatically
        chat = {
          adapter = "opencode",
        },
        -- Inline assistant → fast local model via Ollama
        inline = {
          adapter = "ollama_coder",
        },
        -- Cmd bar completions → same local model
        cmd = {
          adapter = "ollama_coder",
        },
        -- Background tasks (title generation, compacting) → local model
        background = {
          adapter = "ollama_coder",
        },
      },

      -- ── Display ───────────────────────────────────────────────────────────
      display = {
        action_palette = {
          provider = "telescope", -- use telescope for action palette
        },
        chat = {
          render_headers = true,
          show_token_count = true,
        },
      },
    },
  },
}
