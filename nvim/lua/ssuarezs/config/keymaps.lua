local map = vim.keymap.set

map("n", "x", '"_x', { desc = "Delete char without yanking" })
map({ "n", "x" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map({ "n", "x" }, "<leader>c", '"_c', { desc = "Change without yanking" })
map({ "n", "x" }, "<leader>p", '"0p', { desc = "Paste last yank" })
map("n", "dw", 'vb"_d', { desc = "Delete word backward without yanking" })

map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select entire buffer" })

map("n", "te", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<Tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<S-Tab>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

map("n", "sd", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "sh", "<C-w>h", { desc = "Focus left split" })
map("n", "sj", "<C-w>j", { desc = "Focus lower split" })
map("n", "sk", "<C-w>k", { desc = "Focus upper split" })
map("n", "sl", "<C-w>l", { desc = "Focus right split" })

map("n", "<C-m>", "<C-i>", { desc = "Jump forward" })

map("n", "<leader>o", "o<Esc>^Da", { desc = "New line below without comment" })
map("n", "<leader>O", "O<Esc>^Da", { desc = "New line above without comment" })

map("n", "<leader>bd", ssuarezs.editor.close_hidden_buffers, { desc = "Close hidden buffers" })

map("n", "<leader>yf", function()
	ssuarezs.editor.copy_file_location(false)
end, { desc = "Copy relative file location" })
map("n", "<leader>yp", function()
	ssuarezs.editor.copy_file_location(true)
end, { desc = "Copy absolute file location" })
map("x", "<leader>cc", ssuarezs.editor.copy_selection_as_code_block, { desc = "Copy selection as code block" })
map("n", "<leader>j", ssuarezs.editor.show_package_json, { desc = "Show package.json" })
