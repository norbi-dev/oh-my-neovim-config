-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git", "clone", "--filter=blob:none", "--branch=stable",
		"https://github.com/folke/lazy.nvim.git", lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- 1. LazyVim core
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },

		-- 2. LazyVim extras (must come before local plugins)
		{ import = "lazyvim.plugins.extras.dap.core" },
		{
			import = "lazyvim.plugins.extras.lang.typescript",
			cond = function()
				return LazyVim.extras.wants({
					ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
					root = { "tsconfig.json", "package.json", "jsconfig.json" },
				})
			end,
		},
		{
			import = "lazyvim.plugins.extras.lang.python",
			cond = function()
				return LazyVim.extras.wants({
					ft = "python",
					root = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" },
				})
			end,
		},
		{
			import = "lazyvim.plugins.extras.lang.go",
			cond = function()
				return LazyVim.extras.wants({
					ft = { "go", "gomod", "gowork", "gotmpl" },
					root = { "go.work", "go.mod" },
				})
			end,
		},
		{
			import = "lazyvim.plugins.extras.lang.rust",
			cond = function()
				return LazyVim.extras.wants({
					ft = "rust",
					root = { "Cargo.toml", "rust-project.json" },
				})
			end,
		},

		-- 3. Local plugin specs (must be last)
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true, frequency = 86400 }, -- check once per day, not every startup
})
