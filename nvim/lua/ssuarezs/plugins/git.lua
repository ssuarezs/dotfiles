require("gitsigns").setup()

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "", change = "", delete = "" },
		overlay_style = "hunk",
	},
	mappings = {
		goto_prev = "[c",
		goto_next = "]c",
	},
})

require("codediff").setup({
	diff = {
		compact = true,
		compact_context_lines = 8,
		compact_sync_folds = true,
	},
	explorer = {
		width = 50,
		view_mode = "tree",
		auto_open_on_cursor = true,
		line_stats = { enabled = true },
	},
})
ssuarezs.git.track_codediff_tabpages()

require("gitlinker").setup()
