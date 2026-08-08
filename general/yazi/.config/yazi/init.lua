-- require("full-border"):setup()
-- require("session"):setup {
-- 	sync_yanked = true,
-- }

require("vscode-git-colors"):setup()
-- require("no-status"):setup()

local pref_by_location = require("pref-by-location")
pref_by_location:setup({
	prefs = {
		{ location = ".*/Downloads", sort = { "btime", reverse = true, dir_first = true }, linemode = "btime" },
	},
})
