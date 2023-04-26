-- User Command
-- vim.api.nvim_create_user_command({name}, {command}, {opts})
vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})

-- Auto Command
-- vim.api.nvim_create_autocmd({event}, {opts})
local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	group = augroup,
	desc = "Use q to close the window",
	command = "nnoremap <buffer> q <cmd>quit<cr>",
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight on yank",
	callback = function(event)
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})
