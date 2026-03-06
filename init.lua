require("config.lazy")

-- Sync with system clipboard
vim.opt.clipboard = "unnamedplus"

-- === Eye Comfort & UI Settings ===
vim.opt.termguicolors = true   -- Enable 24-bit RGB color
vim.opt.cursorline = true      -- Highlight the current line (helps eyes find the cursor)
vim.opt.laststatus = 3         -- Global statusline (cleaner look)
vim.opt.showmode = false       -- Hide the default "-- INSERT --" text (statusline handles it)
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative numbers (helps with movement commands)
