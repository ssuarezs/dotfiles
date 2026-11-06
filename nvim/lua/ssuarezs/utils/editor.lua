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

return M
