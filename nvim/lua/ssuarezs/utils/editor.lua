local M = {}

function M.close_hidden_buffers()
	local visible = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		visible[vim.api.nvim_win_get_buf(win)] = true
	end

	local closed = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buflisted and not visible[buf] and not vim.bo[buf].modified then
			vim.api.nvim_buf_delete(buf, {})
			closed = closed + 1
		end
	end

	vim.notify(("Closed %d hidden buffer(s)"):format(closed))
end

local SHORT_LANGUAGE_TAGS = {
	typescriptreact = "tsx",
	javascriptreact = "jsx",
	typescript = "ts",
	javascript = "js",
}

local FLOAT_SIZE_RATIO = 0.8

local function copy_to_clipboard(text)
	vim.fn.setreg("+", text)
end

function M.copy_file_location(absolute)
	local path = vim.fn.expand(absolute and "%:p" or "%:.")
	local text = ("%s#L%d"):format(path, vim.fn.line("."))
	copy_to_clipboard(text)
	vim.notify(text)
end

function M.copy_selection_as_code_block()
	local first_line, last_line = vim.fn.line("v"), vim.fn.line(".")
	if first_line > last_line then
		first_line, last_line = last_line, first_line
	end
	local lines = vim.api.nvim_buf_get_lines(0, first_line - 1, last_line, false)
	local language = SHORT_LANGUAGE_TAGS[vim.bo.filetype] or vim.bo.filetype
	local line_range = first_line == last_line and tostring(first_line) or ("%d-%d"):format(first_line, last_line)
	local header = ('```%s filename="%s" line=%s'):format(language, vim.fn.expand("%:."), line_range)

	copy_to_clipboard(table.concat({ header, table.concat(lines, "\n"), "```" }, "\n"))
	vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
end

function M.show_package_json()
	local bufname = vim.api.nvim_buf_get_name(0)
	local start_dir = bufname ~= "" and vim.fs.dirname(bufname) or vim.fn.getcwd()
	local path = vim.fs.find("package.json", { upward = true, path = start_dir })[1]
	if not path then
		vim.notify("No package.json found", vim.log.levels.WARN)
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(path))
	vim.bo[buf].filetype = "json"
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"

	local width = math.floor(vim.o.columns * FLOAT_SIZE_RATIO)
	local height = math.floor(vim.o.lines * FLOAT_SIZE_RATIO)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		title = vim.fn.fnamemodify(path, ":~:."),
		title_pos = "center",
	})

	local function close()
		vim.api.nvim_win_close(win, true)
	end
	vim.keymap.set("n", "q", close, { buffer = buf, desc = "Close" })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf, desc = "Close" })
end

return M
