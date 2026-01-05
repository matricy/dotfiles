-- Execute Lua code quickly
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Execute current line as Lua" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Execute selection as Lua" })
vim.keymap.set("n", "<space>ft", function()
	vim.cmd.vnew()                    -- Create new vertical split
	vim.cmd.term()                    -- Open terminal in that split
	vim.cmd.wincmd("J")               -- Move window to bottom (horizontal)
	vim.api.nvim_win_set_height(0, 15) -- Set height to 15 lines
	job_id = vim.bo.channel           -- Save terminal's job ID
end)

vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", { desc = "Toggle NeoTree" })
