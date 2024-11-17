return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"rcarriga/cmp-dap",
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					enabled = function()
						return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
							or require("cmp_dap").is_dap_buffer()
					end,
				})

				cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
					sources = {
						{ name = "dap" },
					},
				})
			end,
		},
		{
			"hrsh7th/cmp-cmdline",
			config = function()
				local cmp = require("cmp")
				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline({
						["<C-j>"] = {
							c = function()
								if cmp.visible() then
									cmp.select_next_item()
								else
									cmp.complete()
								end
							end,
						},
						["<C-k>"] = {
							c = function()
								if cmp.visible() then
									cmp.select_prev_item()
								else
									cmp.complete()
								end
							end,
						},
					}),
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{ name = "cmdline" },
					}),
				})
			end,
		},
	},
	---@param opts cmp.ConfigSchema
	opts = function(_, opts)
		local cmp = require("cmp")

		opts.completion.autocomplete = false

		opts.mapping = vim.tbl_extend("force", opts.mapping, {
			["<C-j>"] = {
				i = function()
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						cmp.complete()
					end
				end,
			},
			["<C-k>"] = {
				i = function()
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					else
						cmp.complete()
					end
				end,
			},
			["<C-Space>"] = cmp.config.disable,
		})
		return opts
	end,
}
