require("copilot").setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<C-l>",
			accept_word = "<M-l>",
			accept_line = "<M-L>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	filetypes = {
		markdown = true,
		help = true,
	},
	server = {
		type = "binary",
		custom_server_filepath = "copilot-language-server",
	},
})
