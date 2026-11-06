local function lsp_kind_icon(ctx)
	local icon = MiniIcons.get("lsp", ctx.kind)
	return icon .. ctx.icon_gap
end

local function lsp_kind_highlight(ctx)
	local _, highlight = MiniIcons.get("lsp", ctx.kind)
	return highlight
end

require("blink.cmp").setup({
	keymap = { preset = "enter" },
	completion = {
		accept = { auto_brackets = { enabled = true } },
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
		ghost_text = { enabled = false },
		menu = {
			draw = {
				treesitter = { "lsp" },
				components = {
					kind_icon = { text = lsp_kind_icon, highlight = lsp_kind_highlight },
				},
			},
		},
	},
	cmdline = {
		enabled = true,
		completion = {
			list = { selection = { preselect = false } },
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
		},
	},
})

require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = false },
})
