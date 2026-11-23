local wezterm = require("wezterm")

local separators = [[\s"'`()\[\]<>]]
local after_separator = "(?:^|(?<=[" .. separators .. "]))"
local path = "/[^" .. separators .. "]*"
local extension = [[\.\w+]]
local no_more_folders = "(?![^" .. separators .. "]*/)"
local file = path .. extension .. no_more_folders
local relative = after_separator .. "[\\w.+-]+/[^" .. separators .. ":]*[\\w/]"

local shell = os.getenv("SHELL") or "/bin/sh"

local M = {}

local function is_binary(target)
	local ok, mime = wezterm.run_child_process({ "/usr/bin/file", "-b", "--mime", target })
	return ok and mime:find("charset=binary") and not mime:find("^inode/x%-empty")
end

local function resolve_relative(pane, uri)
	local rel = uri:match("^relfile:(.*)")
	if not rel then
		return uri
	end
	local cwd = pane:get_current_working_dir()
	if not cwd then
		return nil
	end
	return "file://" .. cwd.file_path:gsub("/$", "") .. "/" .. rel
end

function M.open_file_uri(window, pane, uri)
	uri = resolve_relative(pane, uri)
	if not uri then
		window:toast_notification("wezterm", "Unknown cwd for relative path", nil, 4000)
		return false
	end
	local url = wezterm.url.parse(uri)
	if url.scheme ~= "file" then
		return
	end
	local target = url.file_path
	local spawn
	if pcall(wezterm.read_dir, target) then
		spawn = { cwd = target, args = { "/opt/homebrew/bin/yazi", target } }
	elseif is_binary(target) then
		wezterm.open_with(target)
		return false
	elseif wezterm.glob(target)[1] then
		spawn = { args = { shell, "-lc", "$EDITOR " .. wezterm.shell_quote_arg(target) } }
	else
		window:toast_notification("wezterm", "Not found: " .. target, nil, 4000)
		return false
	end
	window:perform_action(wezterm.action.SpawnCommandInNewTab(spawn), pane)
	return false
end

local hint_patterns = { after_separator .. "~?/[^" .. separators .. ":]*[\\w/]", relative }
for _, rule in ipairs(wezterm.default_hyperlink_rules()) do
	if rule.format:find("^%$") then
		table.insert(hint_patterns, rule.regex)
	end
end

M.hint_mode = wezterm.action.QuickSelectArgs({
	label = "open",
	patterns = hint_patterns,
	skip_action_on_paste = true,
	action = wezterm.action_callback(function(window, pane)
		local text = window:get_selection_text_for_pane(pane):gsub("^~/", wezterm.home_dir .. "/")
		local uri = text:find("^/") and "file://" .. text
			or (not text:find("^%a[%w+.-]*://") and "relfile:" .. text)
			or text
		if wezterm.emit("open-uri", window, pane, uri) then
			wezterm.open_with(uri)
		end
	end),
})

function M.add_to(rules)
	table.insert(rules, {
		regex = after_separator .. file,
		format = "file://$0",
	})
	table.insert(rules, {
		regex = after_separator .. "~(" .. file .. ")",
		format = "file://" .. wezterm.home_dir .. "$1",
	})
	table.insert(rules, {
		regex = relative,
		format = "relfile:$0",
	})
	return rules
end

return M
