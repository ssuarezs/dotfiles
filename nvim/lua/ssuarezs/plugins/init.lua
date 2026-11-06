vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("ssuarezs.pack", { clear = true }),
	callback = function(event)
		local name, kind = event.data.spec.name, event.data.kind
		if name ~= "nvim-treesitter" or (kind ~= "install" and kind ~= "update") then
			return
		end
		if not event.data.active then
			vim.cmd.packadd(name)
		end
		vim.cmd("TSUpdate")
	end,
})

vim.pack.add({
	"https://github.com/craftzdog/solarized-osaka.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/b0o/incline.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	{ src = "https://github.com/craftzdog/mini.diff", version = "feat/grouping" },
	"https://github.com/esmuellert/codediff.nvim",
	"https://github.com/linrongbin16/gitlinker.nvim",
	"https://github.com/zbirenbaum/copilot.lua",
})

require("ssuarezs.plugins.ui")
require("ssuarezs.plugins.navigation")
require("ssuarezs.plugins.highlighting")
require("ssuarezs.plugins.completion")
require("ssuarezs.plugins.lsp")
require("ssuarezs.plugins.formatting")
require("ssuarezs.plugins.git")
require("ssuarezs.plugins.ai")
require("ssuarezs.plugins.keymaps")
