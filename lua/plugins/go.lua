return {
	{
		"lazyvim.plugins.extras.lang.go",
		cond = function()
			return LazyVim.extras.wants({
				ft = { "go", "gomod", "gowork", "gotmpl" },
				root = { "go.work", "go.mod" },
			})
		end,
	},
}
