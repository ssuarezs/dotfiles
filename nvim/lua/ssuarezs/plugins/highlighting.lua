require("nvim-treesitter").install({
	"astro",
	"bash",
	"c",
	"cmake",
	"cpp",
	"css",
	"diff",
	"fish",
	"gitignore",
	"go",
	"graphql",
	"html",
	"http",
	"java",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"php",
	"printf",
	"python",
	"query",
	"regex",
	"rust",
	"scss",
	"sql",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("ssuarezs.treesitter", { clear = true }),
	callback = function(event)
		local lang = vim.treesitter.language.get_lang(event.match)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end
		vim.treesitter.start(event.buf, lang)
		vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("todo-comments").setup()

require("nvim-highlight-colors").setup({
	render = "background",
	enable_hex = true,
	enable_rgb = true,
	enable_hsl = true,
	enable_ansi = true,
	enable_var_usage = true,
	enable_tailwind = false,
})

vim.lsp.document_color.enable(false)
