-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Suppress "[Process exited]" in terminal buffers (needed for pokemon script
-- in snacks dashboard to render cleanly).
vim.api.nvim_clear_autocmds({ group = "nvim.terminal", event = "TermClose" })


--Enable Treesitter highlighting on all filetypes regardless of size
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable Treesitter highlighting",
	group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

--Enable treesitter highlighting only on files < 100KB
--vim.api.nvim_create_autocmd('FileType', {
--  callback = function(args)
--   local max_filesize = 100 * 1024 -- 100 KB
--    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
--    if ok and stats and stats.size > max_filesize then
--      return
--    end
--    pcall(vim.treesitter.start)
--  end,
--})

-- Treesitter code folding
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable Treesitter folding",
	group = vim.api.nvim_create_augroup("treesitter-folds", { clear = true }),
	callback = function()
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.wo[0][0].foldenable = false -- start with folds open
	end,
})
