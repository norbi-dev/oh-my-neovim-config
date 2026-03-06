# Neovim Config

A LazyVim-based Neovim setup focused on a clean editing experience, multi-language development, local AI assistance, and debugger support — all with fast startup through lazy loading.

## Credits

This config was inspired by the YouTube video
[**0 to LSP: Neovim RC From Scratch**](https://www.youtube.com/watch?v=w7i4amO_zaE)
by ThePrimeagen.

From that foundation, AI capabilities were layered on top:

- **Local ghost-text completion** via [llm.nvim](https://github.com/huggingface/llm.nvim) + [Ollama](https://ollama.com) — fully private, runs on your machine, no API key required
- **Agentic AI chat** via [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) + [OpenCode](https://opencode.ai) — remote or local model, context-aware, file/tool access

The goal: a capable dev environment where local inline completion handles fast, repetitive suggestions, and a remote/local agent handles bigger reasoning tasks.

## Features

- **Theme** — Everforest dark (medium contrast)
- **Languages** — Python, TypeScript, Go, Rust — each loads only when you open a relevant file
- **AI chat** — [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) with [OpenCode](https://opencode.ai) as the agentic backend
- **Ghost-text completion** — [llm.nvim](https://github.com/huggingface/llm.nvim) using a local Ollama model (`qwen2.5-coder:1.5b`), fully private, no API key
- **Debugger** — nvim-dap + nvim-dap-ui, auto-opens on session start
- **UI** — indent guides, rainbow brackets, git gutter signs, inactive window dimming, Zen Mode
- **File tree** — neo-tree with hidden files visible
- **Terminal** — toggleterm with float/horizontal/vertical modes
- **Fuzzy finder** — Telescope

## Prerequisites

| Tool | Min version | Required for |
|------|-------------|--------------|
| [Neovim](https://neovim.io) | **0.11.0** | everything |
| [git](https://git-scm.com) | any | lazy.nvim bootstrap, gitsigns |
| [curl](https://curl.se) | any | Mason, codecompanion, llm-ls download |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | any | Telescope live grep, codecompanion grep tool |
| [Node.js](https://nodejs.org) (via [nvm](https://github.com/nvm-sh/nvm)) | 18+ | Mason LSP installers |
| [Python 3](https://www.python.org) + `python3-venv` | 3.10+ | Python LSP (pyright, ruff), nvim-dap-python |
| [Go](https://go.dev) | 1.21+ | Go LSP (gopls), only needed if using Go |
| [Rust](https://rustup.rs) | stable | Rust LSP (rust-analyzer), only needed if using Rust |
| [Ollama](https://ollama.com) | any | Local ghost-text AI completion |
| [OpenCode](https://opencode.ai) | any | AI chat / agentic development |
| [Nerd Font](https://www.nerdfonts.com) | any | icons in the UI |

> **Note:** Language tools (Go, Rust, Python, TypeScript) are only activated when you open a file of that type or when a project root marker is detected (e.g. `go.mod`, `Cargo.toml`). You don't need all of them installed.

## Installation

### 1. Back up your existing config

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

### 2. Install prerequisites

```bash
# Node.js via nvm (avoids Mason permission errors)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install node

# Ollama
curl -fsSL https://ollama.com/install.sh | sh
ollama pull qwen2.5-coder:1.5b

# OpenCode
# Follow https://opencode.ai/docs/#install
```

### 3. Clone this config

```bash
git clone https://github.com/YOUR_USERNAME/nvim-config ~/.config/nvim
```

### 4. Start Neovim

```bash
nvim
```

Lazy.nvim will bootstrap itself and install all plugins on first launch. Mason will then install the language servers in the background — run `:Mason` to check progress.

## Key Bindings

### AI

| Key | Action |
|-----|--------|
| `<Tab>` | Accept ghost-text completion (llm.nvim) |
| `<S-Tab>` | Dismiss ghost-text completion |
| `<C-a>` | Open CodeCompanion action palette |
| `<leader>ac` | Toggle AI chat buffer |
| `<leader>ai` | Inline AI assistant (prompt-driven) |
| `ga` (visual) | Add selection to chat buffer |

### UI Toggles

| Key | Action |
|-----|--------|
| `<leader>z` | Toggle Zen Mode |
| `<leader>uF` | Toggle inactive window dimming |

### Git (gitsigns)

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / prev hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `<leader>ghd` | Diff this |

### Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |

## Troubleshooting

### Mason npm permission error

```
spawn: npm failed — EACCES: permission denied
```

Use nvm instead of a system Node install — see the [Installation](#installation) section above. If you already have a system Node, fix permissions:

```bash
sudo chown -R $(whoami) ~/.local/share/nvim/mason
```

### Python LSP won't install

```bash
# Debian/Ubuntu
sudo apt install python3-venv

# Fedora/RHEL
sudo dnf install python3-virtualenv
```

### Ghost-text not appearing

1. Check Ollama is running: `curl http://localhost:11434/api/tags`
2. Check llm-ls LSP logs inside Neovim: `:LspLog`
3. Toggle suggestions back on if disabled: `:LLMToggleAutoSuggest`

### Check overall health

```
:checkhealth
:checkhealth codecompanion
```

## Contributing

This is a personal config. Pull requests are not accepted.

If you find it useful, feel free to fork it and adapt it however you like — that's the point. See the [LICENSE](LICENSE) for details.

To extend or modify the config, see [AGENTS.md](AGENTS.md) for the full guide on adding plugins, languages, changing the AI model, and more.

## License

MIT — see [LICENSE](LICENSE).
