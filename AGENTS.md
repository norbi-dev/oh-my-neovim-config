# AGENTS.md — Extending This Config

This document describes how an AI agent (or a human) should approach extending,
modifying, or personalising this Neovim configuration. Read it before making
any changes.

---

## Architecture Overview

```
~/.config/nvim/
├── init.lua                  # Entry point: vim.opt settings, loads config/lazy
├── lua/
│   ├── config/
│   │   └── lazy.lua          # lazy.nvim bootstrap + top-level spec
│   └── plugins/              # One file per plugin (auto-imported via { import = "plugins" })
│       ├── lang.lua          # Language extras (ft-gated)
│       ├── codecompanion.lua # AI chat + inline assistant
│       ├── llm.lua           # Ghost-text completion (local Ollama)
│       ├── everforest.lua    # Colorscheme
│       ├── treesitter.lua    # Syntax + folding
│       ├── telescope.lua     # Fuzzy finder
│       ├── neo-tree.lua      # File tree
│       ├── toggleterm.lua    # Terminal
│       ├── gitsigns.lua      # Git gutter
│       ├── indent-blankline.lua
│       ├── rainbow-delimiters.lua
│       ├── focus.lua         # Inactive window dimming
│       ├── zen-mode.lua      # Distraction-free writing
│       ├── dap-ui.lua        # Debugger UI
│       └── venv-selector.lua # Python venv picker
└── README.md
```

**Key rule:** Every file in `lua/plugins/` is automatically picked up by
`{ import = "plugins" }` in `lazy.lua`. To add a plugin, create a new file
there. To remove one, delete or rename it. No registration elsewhere is needed.

---

## How to Add a Plugin

Create a new file in `lua/plugins/`. Return a lazy.nvim spec table.

```lua
-- lua/plugins/my-plugin.lua
return {
  {
    "author/my-plugin.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- load lazily
    opts = {
      -- plugin options here
    },
  },
}
```

**Always set a lazy trigger** (`event`, `cmd`, `ft`, or `keys`) unless the
plugin absolutely must load at startup (e.g. colorschemes). Plugins without a
trigger load eagerly and slow down startup.

| Trigger | Use when |
|---------|----------|
| `lazy = false` | Colorschemes, plugins that must run before any buffer opens |
| `event = "BufReadPost"` | UI plugins that enhance buffer display |
| `event = "InsertEnter"` | Completion, snippets — only needed while editing |
| `event = "VeryLazy"` | Anything that can wait until Neovim is fully idle |
| `cmd = { "MyCmd" }` | Plugins accessed via a command |
| `keys = { ... }` | Plugins accessed only via a keymap |
| `ft = "python"` | Language-specific plugins |

---

## How to Change the Colorscheme

Edit `lua/plugins/everforest.lua`. Replace the plugin with your theme and
update the `LazyVim` colorscheme opt:

```lua
-- lua/plugins/mytheme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
  },
}
```

Delete `lua/plugins/everforest.lua` after adding the new file.

---

## How to Add a Language

Language support is in `lua/plugins/lang.lua`. Each entry is a LazyVim extra
wrapped in a `cond` guard that activates only when the relevant filetype or
root marker is detected.

To add a new language, append an entry following the same pattern:

```lua
-- Inside lua/plugins/lang.lua, add to the return table:
{
  import = "lazyvim.plugins.extras.lang.ruby",
  cond = function()
    return LazyVim.extras.wants({
      ft = "ruby",
      root = { "Gemfile", ".ruby-version" },
    })
  end,
},
```

Available LazyVim language extras live at:
`~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/`

List them with:
```bash
ls ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/
```

---

## How to Change the AI Chat Model

The chat adapter is `opencode` (ACP). The model is controlled by OpenCode's own
config, not this repo:

```bash
# ~/.config/opencode/config.json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "anthropic/claude-sonnet-4-5"
}
```

To switch to a different codecompanion adapter entirely (e.g. direct Anthropic),
edit the `interactions.chat` field in `lua/plugins/codecompanion.lua`:

```lua
interactions = {
  chat = {
    adapter = "anthropic",  -- uses ANTHROPIC_API_KEY env var
  },
},
```

---

## How to Change the Ghost-Text Model

The ghost-text model is configured in `lua/plugins/llm.lua`. To swap the model:

1. Pull the new model: `ollama pull <model>`
2. Check its FIM tokens from the modelfile:
   ```bash
   curl -s http://localhost:11434/api/show -d '{"name":"<model>"}' | python3 -c \
     "import sys,json; print(json.load(sys.stdin)['modelfile'][:400])"
   ```
3. Update `lua/plugins/llm.lua`:
   ```lua
   model = "deepseek-coder:1.3b",
   fim = {
     enabled = true,
     prefix = "<｜fim▁begin｜>",   -- from modelfile
     middle = "<｜fim▁hole｜>",
     suffix = "<｜fim▁end｜>",
   },
   ```

If the model doesn't support FIM, set `fim = { enabled = false }` — it will
fall back to standard completion but quality will be worse.

**Good lightweight FIM models for local use:**
- `qwen2.5-coder:1.5b` (current, ~1GB)
- `deepseek-coder:1.3b` (~800MB)
- `starcoder2:3b` (~2GB, higher quality)

---

## How to Add Keymaps

For global keymaps, add to `init.lua` or a dedicated `lua/plugins/keymaps.lua`:

```lua
-- lua/plugins/keymaps.lua
return {} -- empty spec, just side effects

vim.keymap.set("n", "<leader>xx", "<cmd>SomeCommand<cr>", { desc = "Do something" })
```

For plugin-specific keymaps, define them inside the plugin's `keys` table —
this is the preferred approach as it also triggers lazy loading:

```lua
{
  "some/plugin",
  keys = {
    { "<leader>xx", "<cmd>SomeCommand<cr>", desc = "Do something" },
  },
}
```

**Leader key** is `<Space>`. **Local leader** is `\`.

Follow LazyVim's keymap namespace conventions to avoid conflicts:
- `<leader>f` — find/telescope
- `<leader>g` — git
- `<leader>c` — code actions
- `<leader>d` — debug
- `<leader>u` — UI toggles
- `<leader>a` — AI (this config)
- `<leader>z` — zen mode (this config)

---

## How to Override a LazyVim Default Plugin

LazyVim manages many plugins internally. To override one, create a file in
`lua/plugins/` that references the same plugin with `optional = true`:

```lua
-- lua/plugins/override-lualine.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        component_separators = "|",
        section_separators = "",
      },
    },
  },
}
```

Do not set `optional = true` for plugins you are adding from scratch — only
for plugins already managed by LazyVim that you want to tweak.

---

## How to Add a LazyVim Extra (Non-Language)

LazyVim has extras beyond languages. Add them in `lazy.lua` inside the `spec`
table:

```lua
{ import = "lazyvim.plugins.extras.editor.harpoon2" },
{ import = "lazyvim.plugins.extras.formatting.prettier" },
{ import = "lazyvim.plugins.extras.linting.eslint" },
```

Browse available extras:
```bash
ls ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/
```

---

## Conventions to Follow

- **One plugin per file** in `lua/plugins/` — makes diffing and reverting easy
- **Always lazy-load** — use `event`, `cmd`, `ft`, or `keys`
- **Use `opts =` not `config =`** when the plugin supports `setup()` — it's
  cleaner and lazy.nvim merges `opts` tables automatically
- **Use `config = function(_, opts)`** only when you need logic beyond `setup(opts)`
- **No `vim.cmd` colorscheme calls** — set the colorscheme via
  `LazyVim/LazyVim opts.colorscheme`
- **Check health after changes** — run `:checkhealth` and `:Lazy` to confirm
  no errors

---

## Checking What's Loaded and Why

```
:Lazy          — plugin manager UI, shows load times and status
:Lazy profile  — startup profiling, shows which plugins are slowest
:LspInfo       — active LSP clients for the current buffer
:Mason         — installed/available LSP servers, formatters, linters
:checkhealth   — overall health check
:checkhealth codecompanion  — AI adapter connectivity
:LspLog        — raw LSP logs (useful for llm-ls debugging)
```
