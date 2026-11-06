local M = {}

local MAX_NAME_LENGTH = 20
local TRUNCATED_LENGTH = 17
local PADDING = "   "
local LEFT_SEPARATOR = "\u{E0BA}"
local RIGHT_SEPARATOR = "\u{E0B8}"

local function truncate_end(text)
	if vim.fn.strchars(text) <= MAX_NAME_LENGTH then
		return text
	end
	return vim.fn.strcharpart(text, 0, TRUNCATED_LENGTH) .. "…"
end

local function truncate_start(text)
	local length = vim.fn.strchars(text)
	if length <= MAX_NAME_LENGTH then
		return text
	end
	return "…" .. vim.fn.strcharpart(text, length - TRUNCATED_LENGTH)
end

local function oil_directory(bufname)
	local path = bufname:gsub("^oil://", "")
	return truncate_start(vim.fn.fnamemodify(path, ":~"))
end

local function tab_label(tabpage)
	local buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
	local bufname = vim.api.nvim_buf_get_name(buf)

	local label
	if vim.bo[buf].buftype == "terminal" then
		label = "[Terminal]"
	elseif vim.bo[buf].filetype == "oil" or bufname:match("^oil://") then
		label = oil_directory(bufname)
	elseif bufname == "" then
		label = "[No Name]"
	else
		local filename = vim.fn.fnamemodify(bufname, ":t")
		local icon = require("mini.icons").get("file", filename)
		label = icon .. " " .. truncate_end(filename)
	end

	if vim.bo[buf].modified then
		label = "[+] " .. label
	end
	return label
end

function M.render()
	local current = vim.api.nvim_get_current_tabpage()
	local parts = {}

	for index, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		local group = tabpage == current and "TablineActive" or "TablineInactive"
		table.insert(parts, ("%%%dT"):format(index))
		table.insert(parts, ("%%#%sSeparator#%s"):format(group, LEFT_SEPARATOR))
		local label = tab_label(tabpage):gsub("%%", "%%%%")
		table.insert(parts, ("%%#%s#%s%s%s"):format(group, PADDING, label, PADDING))
		table.insert(parts, ("%%#%sSeparator#%s"):format(group, RIGHT_SEPARATOR))
	end

	table.insert(parts, "%#TabLineFill#%T")
	return table.concat(parts)
end

function M.set_highlights()
	local colors = require("solarized-osaka.colors").setup()
	vim.api.nvim_set_hl(0, "TablineActive", { fg = colors.base4, bg = colors.yellow, bold = true })
	vim.api.nvim_set_hl(0, "TablineActiveSeparator", { fg = colors.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "TablineInactive", { fg = colors.base0, bg = colors.base02 })
	vim.api.nvim_set_hl(0, "TablineInactiveSeparator", { fg = colors.base02, bg = "NONE" })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
end

function M.setup()
	M.set_highlights()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("ssuarezs.tabline", { clear = true }),
		callback = M.set_highlights,
	})
	vim.o.showtabline = 1
	vim.o.tabline = "%!v:lua.ssuarezs.tabline.render()"
end

return M
