return {
  {
    "huggingface/llm.nvim",
    lazy = false,
    opts = {
      backend = "ollama",
      url = "http://localhost:11434",
      model = "qwen2.5-coder:1.5b",
      tokens_to_clear = { "<|endoftext|>" },
      -- FIM tokens confirmed from qwen2.5-coder:1.5b modelfile
      fim = {
        enabled = true,
        prefix = "<|fim_prefix|>",
        middle = "<|fim_middle|>",
        suffix = "<|fim_suffix|>",
      },
      context_window = 4096,
      debounce_ms = 150,
      -- accept_keymap is owned by llm.nvim; it uses expr=true so it falls
      -- through to blink.cmp when no suggestion is active — no conflict
      accept_keymap = "<Tab>",
      dismiss_keymap = "<S-Tab>",
      enable_suggestions_on_startup = true,
      enable_suggestions_on_files = "*",
      request_body = {
        -- raw = true bypasses Ollama's chat template so FIM tokens are passed
        -- directly to the model — this prevents reasoning/markdown wrapping
        raw = true,
        options = {
          temperature = 0.1,
          top_p = 0.95,
          num_predict = 128,
        },
      },
      lsp = {
        version = "0.5.3",
      },
    },
  },
}
