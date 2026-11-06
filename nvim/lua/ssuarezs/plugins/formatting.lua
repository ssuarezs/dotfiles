local WEB_FORMATTERS = { "oxfmt", "prettierd", "prettier", stop_after_first = true }
local OXFMT_CONFIG_FILES = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }
local VITE_CONFIG_FILES = { "vite.config.ts", "vite.config.js", "vite.config.mts", "vite.config.mjs" }

local function vite_config_declares_fmt(path)
	local file = io.open(path, "r")
	if not file then
		return false
	end
	local content = file:read("*a")
	file:close()
	return content:find("%f[%w_]fmt%s*:") ~= nil
end

local function project_uses_oxfmt(_, ctx)
	if vim.fs.root(ctx.dirname, OXFMT_CONFIG_FILES) then
		return true
	end
	local vite_config = vim.fs.find(VITE_CONFIG_FILES, { path = ctx.dirname, upward = true })[1]
	return vite_config ~= nil and vite_config_declares_fmt(vite_config)
end

require("conform").setup({
	formatters_by_ft = {
		javascript = WEB_FORMATTERS,
		javascriptreact = WEB_FORMATTERS,
		typescript = WEB_FORMATTERS,
		typescriptreact = WEB_FORMATTERS,
		json = WEB_FORMATTERS,
		jsonc = WEB_FORMATTERS,
		css = WEB_FORMATTERS,
		scss = WEB_FORMATTERS,
		less = WEB_FORMATTERS,
		html = WEB_FORMATTERS,
		markdown = WEB_FORMATTERS,
		mdx = WEB_FORMATTERS,
		yaml = WEB_FORMATTERS,
		lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		zsh = { "shfmt" },
		fish = { "fish_indent" },
	},
	formatters = {
		oxfmt = { condition = project_uses_oxfmt },
	},
	format_on_save = function(bufnr)
		if vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 1000, lsp_format = "fallback" }
	end,
})
