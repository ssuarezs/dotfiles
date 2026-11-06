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
})

require("ssuarezs.plugins.ui")
require("ssuarezs.plugins.navigation")
require("ssuarezs.plugins.highlighting")
require("ssuarezs.plugins.keymaps")
