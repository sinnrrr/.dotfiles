local wezterm = require("wezterm")

local separators = [[\s"'`()\[\]<>]]
local after_separator = "(?:^|(?<=[" .. separators .. "]))"
local path = "/[^" .. separators .. "]*"
local extension = [[\.\w+]]
local no_more_folders = "(?![^" .. separators .. "]*/)"
local file = path .. extension .. no_more_folders

local M = {}

function M.open_dir_in_yazi(window, pane, uri)
	local url = wezterm.url.parse(uri)
	if url.scheme ~= "file" or not pcall(wezterm.read_dir, url.file_path) then
		return
	end
	window:perform_action(
		wezterm.action.SpawnCommandInNewTab({
			cwd = url.file_path,
			args = { "/opt/homebrew/bin/yazi", url.file_path },
		}),
		pane
	)
	return false
end

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
