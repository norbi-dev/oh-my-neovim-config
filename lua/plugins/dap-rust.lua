-- Rust debug support via codelldb + nvim-dap.
-- rustaceanvim (loaded by lang.lua) wires the DAP adapter automatically when
-- mason's codelldb is present. This file ensures nvim-dap is loaded for Rust
-- buffers and registers a fallback codelldb adapter + configurations so that
-- standard DAP commands (:DapToggleBreakpoint, :DapContinue, etc.) work even
-- when invoked outside of rustaceanvim's RustLsp debuggables workflow.
return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    ft = { "rust" },
    config = function()
      local dap = require("dap")

      -- Only register if codelldb is available and not already set by rustaceanvim
      if not dap.adapters.codelldb then
        local codelldb_path = vim.fn.exepath("codelldb")
        if codelldb_path ~= "" then
          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--port", "${port}" },
            },
          }
        end
      end

      -- Register Rust DAP configurations if not already present
      if not dap.configurations.rust then
        dap.configurations.rust = {
          {
            name = "Launch binary (debug)",
            type = "codelldb",
            request = "launch",
            -- Looks for the debug binary matching the current file's crate name.
            -- Override with a static path when needed.
            program = function()
              local cwd = vim.fn.getcwd()
              local cargo_toml = cwd .. "/Cargo.toml"
              local name = nil
              -- Try to read the package name from Cargo.toml
              local f = io.open(cargo_toml, "r")
              if f then
                for line in f:lines() do
                  name = line:match('^%s*name%s*=%s*"([^"]+)"')
                  if name then break end
                end
                f:close()
              end
              local default = name and (cwd .. "/target/debug/" .. name) or (cwd .. "/target/debug/app")
              return vim.fn.input("Binary path: ", default, "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
          {
            name = "Attach to process",
            type = "codelldb",
            request = "attach",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
