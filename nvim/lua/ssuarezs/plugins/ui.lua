require("solarized-osaka").setup({
	style = "vivid",
	transparent = true,
})
vim.cmd.colorscheme("solarized-osaka")

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

ssuarezs.tabline.setup()

local PROJECT_ROOT_MARKERS = { ".git", "lua", "package.json", "Makefile", "Cargo.toml", "go.mod", "pyproject.toml" }

local function project_root_name()
	local root = vim.fs.root(0, PROJECT_ROOT_MARKERS)
	if not root or root == vim.fn.getcwd() then
		return ""
	end
	return vim.fn.fnamemodify(root, ":t")
end

local function recording_macro()
	local register = vim.fn.reg_recording()
	if register == "" then
		return ""
	end
	return "recording @" .. register
end

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		refresh = {
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
				"RecordingEnter",
				"RecordingLeave",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			project_root_name,
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ "filename", path = 1 },
		},
		lualine_x = { recording_macro, "diagnostics", "diff" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

require("incline").setup({
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		if filename == "" then
			filename = "[No Name]"
		end
		local icon, icon_group = MiniIcons.get("file", filename)
		return {
			{ icon, group = icon_group },
			" ",
			{ filename, gui = "bold" },
			vim.bo[props.buf].modified and " [+]" or "",
		}
	end,
})

require("snacks").setup({
	notifier = { enabled = true },
	indent = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	scroll = { enabled = false },
})

require("tiny-cmdline").setup({
	position = { x = "50%", y = "20%" },
})
