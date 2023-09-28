return {
	"nvim-lualine/lualine.nvim",
	opts = function()
		local icons = require("lazyvim.config").icons
		local Util = require("lazyvim.util")

		return {
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{
						function()
							return string.format("terminal (%d)", vim.b.toggle_number)
						end,
						cond = function()
							return vim.bo.filetype == "toggleterm"
						end,
					},
					{
						"filename",
						path = 1,
						symbols = { modified = "  ", readonly = "", unnamed = "" },
						cond = function()
							return vim.bo.filetype ~= "toggleterm"
						end,
					},
				},
				lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.fg("Debug"),
          },
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = Util.fg("Special"),
					},
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
					},
				},
				lualine_y = {
					function()
						local bufnr = vim.api.nvim_get_current_buf()
						local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
						if next(clients) == nil then
							return ""
						end

						local c = {}
						for _, client in pairs(clients) do
							if client.name ~= "null-ls" then
								table.insert(c, client.name)
							end
						end
						return "\u{f085} " .. table.concat(c, "|")
					end,
				},
			},
			extensions = { "lazy" },
		}
	end,
}