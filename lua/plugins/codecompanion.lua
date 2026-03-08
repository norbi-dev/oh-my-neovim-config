return {
	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Render markdown nicely in the chat buffer
			{
				"MeanderingProgrammer/render-markdown.nvim",
				ft = { "markdown", "codecompanion" },
			},
		},
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionCmd",
			"CodeCompanionActions",
		},
		keys = {
			{
				"<C-a>",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				desc = "CodeCompanion Actions",
			},
			{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
			{ "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline Assistant" },
			{
				"ga",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = "v",
				desc = "Add selection to chat",
			},
			{
				"<leader>am",
				function()
					local config_path = vim.fn.expand("~/.config/opencode/config.json")
					local models = {
						"anthropic/claude-sonnet-4-6",
						"anthropic/claude-opus-4-6",
						"anthropic/claude-haiku-4-5",
						"openai/gpt-4o-mini",
					}
					-- Read current model for display
					local current = "unknown"
					local f = io.open(config_path, "r")
					if f then
						local raw = f:read("*a")
						f:close()
						current = raw:match('"model"%s*:%s*"([^"]+)"') or current
					end
					vim.ui.select(models, {
						prompt = "Switch OpenCode model (current: " .. current .. "):",
					}, function(choice)
						if not choice then
							return
						end
						local json = string.format(
							'{\n  "$schema": "https://opencode.ai/config.json",\n  "model": "%s"\n}\n',
							choice
						)
						local wf = io.open(config_path, "w")
						if wf then
							wf:write(json)
							wf:close()
							vim.notify("OpenCode model → " .. choice, vim.log.levels.INFO)
						else
							vim.notify("Failed to write " .. config_path, vim.log.levels.ERROR)
						end
					end)
				end,
				desc = "Switch AI model",
			},
		},
		opts = {
			-- ── Adapters ──────────────────────────────────────────────────────────
			adapters = {
				-- Ollama local adapter — used for lightweight inline autocomplete
				ollama_coder = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = "ollama_coder",
						schema = {
							model = {
								default = "qwen2.5-coder:1.5b",
							},
							-- Keep responses fast for inline use
							num_ctx = {
								default = 4096,
							},
							temperature = {
								default = 0.1,
							},
						},
					})
				end,
			},

			-- ── Interactions ──────────────────────────────────────────────────────
			interactions = {
				-- Chat & agentic work → OpenCode ACP adapter
				-- Reads model from ~/.config/opencode/config.json automatically
				chat = {
					adapter = "opencode",
				},
				-- Inline assistant → fast local model via Ollama
				inline = {
					adapter = "ollama_coder",
				},
				-- Cmd bar completions → same local model
				cmd = {
					adapter = "ollama_coder",
				},
				-- Background tasks (title generation, compacting) → local model
				background = {
					adapter = "ollama_coder",
				},
			},

			-- ── Display ───────────────────────────────────────────────────────────
			display = {
				action_palette = {
					provider = "telescope", -- use telescope for action palette
				},
				chat = {
					render_headers = true,
					show_token_count = true,
				},
			},
		},
	},
}
