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
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
        agent = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = { default = "qwen2.5-coder:7b" },
              num_ctx = { default = 8192 },
            },
          })
        end,
      },
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff", 
        },
      },
      -- FIXED SECTION BELOW
      prompt_library = {
        ["Refactor"] = {
          strategy = "inline",
          description = "Refactor the selected code",
          opts = {
            modes = { "v" },
            short_name = "refactor",
            auto_submit = true,
            user_prompt = false,
            stop_context_insertion = true, -- This means YOU must provide the code manually below
          },
          prompts = {
            {
              role = "system",
              content = "You are an expert refactoring assistant. Refactor the code for clarity. Return ONLY the code.",
            },
            {
              role = "user",
              content = function(context)
                -- FIX: Read the lines from the buffer using the context line numbers
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                
                -- Fallback if the helper isn't available (standard Vim API):
                if not text then
                  local lines = vim.api.nvim_buf_get_lines(context.bufnr, context.start_line - 1, context.end_line, false)
                  text = table.concat(lines, "\n")
                end

                return "Refactor this code:\n" .. text
              end,
            },
          },
        },
      },
      -- END FIXED SECTION
    })
  end,
}