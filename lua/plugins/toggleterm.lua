return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
		{ "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal Terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical Terminal" },
	},
	opts = {
		size = 20,
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},
}
