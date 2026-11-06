local M = {}

local function show_locations(locations, client)
	if #locations == 1 then
		vim.lsp.util.show_document(locations[1], client.offset_encoding, { focus = true })
		return
	end
	vim.fn.setqflist({}, " ", {
		title = "Source definitions",
		items = vim.lsp.util.locations_to_items(locations, client.offset_encoding),
	})
	vim.cmd.copen()
end

function M.goto_source_definition()
	local client = vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })[1]
	if not client then
		Snacks.picker.lsp_implementations()
		return
	end

	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
	client:request("workspace/executeCommand", {
		command = "typescript.goToSourceDefinition",
		arguments = { params.textDocument.uri, params.position },
	}, function(err, locations)
		if err then
			vim.notify(err.message, vim.log.levels.ERROR)
		elseif not locations or #locations == 0 then
			vim.notify("No source definition found", vim.log.levels.WARN)
		else
			show_locations(locations, client)
		end
	end, 0)
end

return M
