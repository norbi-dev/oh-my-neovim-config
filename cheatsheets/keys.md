# ⚡ LazyVim Navigation Cheatsheet

A streamlined guide for high-speed code and UI navigation in [LazyVim](https://www.lazyvim.org/).

---

## 📂 File & Buffer Navigation
*LazyVim uses buffers (shown at the top) rather than traditional tabs.*

| Keybind | Action |
| :--- | :--- |
| `H` | Previous Buffer (Left) |
| `L` | Next Buffer (Right) |
| `<leader>bb` | Switch to last used buffer |
| `<leader>bd` | Close current buffer |
| `<leader>e` | Toggle Neo-tree (File Explorer) |
| `<leader>fb` | List all open buffers (Telescope) |

---

## 🔍 Search & Find (Telescope)
| Keybind | Action |
| :--- | :--- |
| `<leader><space>` | **Find Files** (Search by name) |
| `<leader>/` | **Live Grep** (Search text globally) |
| `<leader>fr` | Recent Files |
| `<leader>sw` | Search current Word under cursor |
| `<leader>sk` | Search Keymaps (Find any shortcut) |

---

## 💻 Code Intelligence (LSP)
| Keybind | Action |
| :--- | :--- |
| `gd` | **Go to Definition** |
| `gr` | **Go to References** |
| `gI` | Go to Implementation |
| `K` | Hover Documentation |
| `]d` / `[d` | Next / Prev Diagnostic (Error/Warning) |
| `<leader>ca` | Code Action (Quick fix) |
| `<leader>cr` | Rename symbol |

---

## 🪟 Window Management
| Keybind | Action |
| :--- | :--- |
| `Ctrl + h/j/k/l` | Move between windows (Left/Down/Up/Right) |
| `<leader>w|` | Split window vertically |
| `<leader>w-` | Split window horizontally |
| `<leader>wd` | Close current window |

---

## 🚀 Advanced Movement
| Keybind | Action |
| :--- | :--- |
| `s` | **Flash Jump**: Type 2 chars, then the label to teleport |
| `<leader>st` | Open Todo-comments list |
| `Alt + i` | Open Floating Terminal |
| `gc` | Comment out line/selection |

---

> **Tip:** If you get stuck, just press the `<leader>` (Space) key and wait. The **Which-Key** menu will appear to show you all available sub-commands.
