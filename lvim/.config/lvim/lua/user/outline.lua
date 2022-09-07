local M = {}

M.config = function()
	require("symbols-outline").setup({
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false,
		position = "right",
		width = 35,
		autofold_depth = 0,
		auto_unfold_hover = false,
		show_numbers = false,
		show_relative_numbers = false,
		show_symbol_details = true,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "K",
			toggle_preview = "p",
			rename_symbol = "r",
			code_actions = "a",
			fold = "h",
			unfold = "l",
			fold_all = "H",
			unfold_all = "L",
			fold_reset = "R",
		},
		lsp_blacklist = {},
		symbol_blacklist = {},
		symbols = {
			File = { icon = "", hl = "TSURI" },
			Module = { icon = "", hl = "TSNamespace" },
			Namespace = { icon = "", hl = "TSNamespace" },
			Package = { icon = "", hl = "TSNamespace" },
			Class = { icon = "", hl = "TSType" },
			Method = { icon = "", hl = "TSMethod" },
			Property = { icon = "襁", hl = "TSMethod" },
			-- Field = { icon = "", hl = "TSField" },
			Field = { icon = "ﴲ", hl = "TSField" },
			Constructor = { icon = "", hl = "TSConstructor" },
			Enum = { icon = "練", hl = "TSType" },
			Interface = { icon = "ﰮ", hl = "TSType" },
			Function = { icon = "", hl = "TSFunction" },
			Variable = { icon = "", hl = "TSConstant" },
			Constant = { icon = "ﲀ", hl = "TSConstant" },
			String = { icon = "", hl = "TSString" },
			Number = { icon = "#", hl = "TSNumber" },
			Boolean = { icon = "⊨", hl = "TSBoolean" },
			Array = { icon = "", hl = "TSConstant" },
			Object = { icon = "⦿", hl = "TSType" },
			Key = { icon = "", hl = "TSType" },
			Null = { icon = "NULL", hl = "TSType" },
			EnumMember = { icon = "", hl = "TSField" },
			Struct = { icon = "ﳤ", hl = "TSType" },
			Event = { icon = "", hl = "TSType" },
			Operator = { icon = "+", hl = "TSOperator" },
			TypeParameter = { icon = "", hl = "TSParameter" },
		},
	})
end

return M