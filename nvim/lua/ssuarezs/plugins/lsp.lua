require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"vtsls",
		"eslint-lsp",
		"oxlint",
		"tailwindcss-language-server",
		"css-lsp",
		"rust-analyzer",
		"copilot-language-server",
		"prettier",
		"prettierd",
		"oxfmt",
		"stylua",
		"shfmt",
	},
	auto_update = false,
	run_on_start = true,
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities({
		workspace = {
			fileOperations = { willRename = true, didRename = true },
		},
	}),
})

vim.lsp.enable({
	"eslint",
	"oxlint",
	"lua_ls",
	"cssls",
	"vtsls",
	"tailwindcss",
	"rust_analyzer",
})

local DIAGNOSTIC_ICONS = {
	[vim.diagnostic.severity.ERROR] = "\u{F057} ",
	[vim.diagnostic.severity.WARN] = "\u{F071} ",
	[vim.diagnostic.severity.INFO] = "\u{F05A} ",
	[vim.diagnostic.severity.HINT] = "\u{F0EB} ",
}

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	signs = { text = DIAGNOSTIC_ICONS },
	float = { source = "if_many" },
})
