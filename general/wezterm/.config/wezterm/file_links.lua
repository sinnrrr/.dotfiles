local wezterm = require("wezterm")

local separators = [[\s"'`()\[\]<>]]
local after_separator = "(?:^|(?<=[" .. separators .. "]))"
local path = "/[^" .. separators .. "]*"
local extension = [[\.\w+]]
local no_more_folders = "(?![^" .. separators .. "]*/)"
local file = path .. extension .. no_more_folders

local M = {}

function M.add_to(rules)
	table.insert(rules, {
		regex = after_separator .. file,
		format = "file://$0",
	})
	table.insert(rules, {
		regex = after_separator .. "~(" .. file .. ")",
		format = "file://" .. wezterm.home_dir .. "$1",
	})
	return rules
end

return M
