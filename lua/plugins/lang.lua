-- Language extras loaded conditionally based on filetype or project root markers.
-- Each extra only activates when the relevant file type is opened or root files are found,
-- keeping startup clean when working outside these languages.
return {
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
}
