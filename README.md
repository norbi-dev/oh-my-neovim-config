# Welcome


`The error spawn: npm failed with exit code - and signal -. Failed to spawn process cmd=npm err=EACCES: permission denied indicates a permission issue preventing Mason`

## ⚠️ Troubleshooting Installation Errors

If you encounter issues during the language server installation via Mason, especially permission errors, please consult this section.

### Error: `spawn: npm failed with exit code - and signal -. Failed to spawn process cmd=npm err=EACCES: permission denied`

This error means the installer (often Mason) could not execute the `npm` command due to insufficient permissions. This commonly happens on Unix/Linux systems when globally installed packages are managed by the system root user (`sudo`).

This error occurs even when installing Python-based tools like **Ruff** because some LSP servers (`ruff-lsp`) or their dependencies rely on Node.js/npm for installation scripts.

#### Solutions (Choose One):

| Solution | Description | Commands |
| :--- | :--- | :--- |
| **1. Use NVM (Recommended)** | Use Node Version Manager to install Node.js and npm in your user's directory, avoiding system-level permissions entirely. | 1. Install NVM (See NVM documentation).<br>2. `nvm install node`<br>3. `nvm use node` |
| **2. Fix Global npm Permissions** | If you must use a system-wide Node/npm installation, ensure your user owns the necessary directories. | 1. `sudo chown -R $(whoami) /usr/local/lib/node_modules`<br>2. `sudo chown -R $(whoami) /usr/local/bin`<br>3. **Optional:** `npm config set prefix '~/.npm-global'` and update your `$PATH` (see general npm documentation). |
| **3. Fix Mason's Data Permissions** | Ensure your user has full control over the directory where Mason saves its installed binaries. | `sudo chown -R $(whoami) ~/.local/share/nvim/mason` |

### 🐛 Troubleshooting Python Tools (e.g., Ruff, Pyright)

If the error persists specifically for Python language servers:

1.  **Install `python3-venv`:** Ensure your system has the necessary package to create isolated Python virtual environments, which Mason relies on.
    * **Debian/Ubuntu:** `sudo apt install python3-venv`
    * **Fedora/RHEL:** `sudo dnf install python3-virtualenv`

2.  **Manually Install the LSP (Advanced Alternative):** If automated installation fails, install the LSP server using the `--user` flag and configure Mason to use it.
    ```bash
    # Install ruff-lsp to your user's directory (~/.local/bin)
    pip install ruff-lsp --user
    ```
    Then, ensure `~/.local/bin` is in your `$PATH`. Mason should detect this installation if the path is correct.
