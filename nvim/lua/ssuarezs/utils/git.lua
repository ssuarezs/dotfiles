local M = {}

local UNCOMMITTED_SHA = string.rep("0", 40)

local lazygit_window
local lazygit_origin_window
local codediff_tabpages = {}

function M.open_lazygit()
	lazygit_origin_window = vim.api.nvim_get_current_win()
	lazygit_window = Snacks.lazygit({
		theme = {
			activeBorderColor = { fg = "WarningMsg", bold = true },
		},
	})
end

function M.edit_from_lazygit(path, line)
	vim.schedule(function()
		if lazygit_window then
			lazygit_window:close()
			lazygit_window = nil
		end
		if lazygit_origin_window and vim.api.nvim_win_is_valid(lazygit_origin_window) then
			vim.api.nvim_set_current_win(lazygit_origin_window)
		end
		vim.cmd.edit(vim.fn.fnameescape(path))
		if line then
			vim.api.nvim_win_set_cursor(0, { tonumber(line), 0 })
		end
	end)
	return ""
end

local function blame_current_line()
	local file = vim.api.nvim_buf_get_name(0)
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local result = vim.system({
		"git",
		"blame",
		"--porcelain",
		"-L",
		("%d,%d"):format(line, line),
		"--",
		vim.fs.basename(file),
	}, { cwd = vim.fs.dirname(file), text = true }):wait()
	if result.code ~= 0 then
		return nil, vim.trim(result.stderr)
	end
	local sha, original_line = result.stdout:match("^(%x+) (%d+)")
	local original_path = result.stdout:match("\nfilename ([^\n]+)")
	return { sha = sha, line = tonumber(original_line), path = original_path }
end

function M.open_line_revision()
	local blame, err = blame_current_line()
	if not blame then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end
	if blame.sha == UNCOMMITTED_SHA then
		vim.notify("Line is not committed yet", vim.log.levels.WARN)
		return
	end
	require("gitsigns").show(("%s:%s"):format(blame.sha, blame.path), { open = "tabnew" }, function(show_err)
		if show_err then
			vim.notify(show_err, vim.log.levels.ERROR)
			return
		end
		vim.schedule(function()
			pcall(vim.api.nvim_win_set_cursor, 0, { blame.line, 0 })
		end)
	end)
end

function M.toggle_buffer_stage()
	local gitsigns = require("gitsigns")
	local unstaged_hunks = gitsigns.get_hunks() or {}
	if #unstaged_hunks > 0 then
		gitsigns.stage_buffer()
	else
		gitsigns.reset_buffer_index()
	end
end

function M.track_codediff_tabpages()
	local group = vim.api.nvim_create_augroup("ssuarezs.codediff", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "CodeDiffOpen",
		callback = function(event)
			codediff_tabpages[event.data.tabpage] = true
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "CodeDiffClose",
		callback = function(event)
			codediff_tabpages[event.data.tabpage] = nil
		end,
	})
end

function M.toggle_codediff()
	local current = vim.api.nvim_get_current_tabpage()
	if codediff_tabpages[current] then
		vim.cmd.tabclose()
		return
	end
	for tabpage in pairs(codediff_tabpages) do
		if vim.api.nvim_tabpage_is_valid(tabpage) then
			vim.api.nvim_set_current_tabpage(tabpage)
			return
		end
	end
	vim.cmd("CodeDiff")
end

return M
