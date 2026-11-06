vim.api.nvim_create_user_command("ToggleFormatter", function()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
	local state = vim.b.disable_autoformat and "disabled" or "enabled"
	vim.notify(("Format on save %s for this buffer"):format(state))
end, { desc = "Toggle format on save for the current buffer" })
