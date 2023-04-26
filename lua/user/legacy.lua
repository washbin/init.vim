vim.api.nvim_exec(
	[[
    """ Integrated terminal opens in insert mode and mapped to Ctrl t
    set splitbelow
    nnoremap <silent> <C-t> :split term://bash<CR> :set nonu<CR> :set nornu<CR> :resize 15<CR> i

    """ Set cursorline only in active window
    augroup cursor_off
        autocmd!
        autocmd WinLeave * set nocursorline
        autocmd WinEnter * set cursorline
    augroup END

	" Credit: Mahesh C. Regmi (Handsome Devops 20XX)
	function! s:ZoomToggle() abort
	    if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	    else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	    endif
	endfunction
	command! ZoomToggle call s:ZoomToggle()
	nnoremap <silent> <leader>z :ZoomToggle<CR>

    " Copilot keybind
    imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true

    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end

    " auto-format
    autocmd BufWritePre *.ts lua vim.lsp.buf.format()
    autocmd BufWritePre *.tsx lua vim.lsp.buf.format()
    autocmd BufWritePre *.js lua vim.lsp.buf.format()
    autocmd BufWritePre *.jsx lua vim.lsp.buf.format()
    autocmd BufWritePre *.html lua vim.lsp.buf.format()
    autocmd BufWritePre *.css lua vim.lsp.buf.format()
    autocmd BufWritePre *.py lua vim.lsp.buf.format()
    autocmd BufWritePre *.c lua vim.lsp.buf.format()
    autocmd BufWritePre *.h lua vim.lsp.buf.format()
    autocmd BufWritePre *.cpp lua vim.lsp.buf.format()
    autocmd BufWritePre *.hpp lua vim.lsp.buf.format()
    autocmd BufWritePre *.go lua vim.lsp.buf.format()
    autocmd BufWritePre *.rs lua vim.lsp.buf.format()
    autocmd BufWritePre *.tf lua vim.lsp.buf.format()
    autocmd BufWritePre *.dart lua vim.lsp.buf.format()
    autocmd BufWritePre *.elm lua vim.lsp.buf.format()
    autocmd BufWritePre *.ex lua vim.lsp.buf.format()
    autocmd BufWritePre *.prisma lua vim.lsp.buf.format()
    autocmd BufWritePre *.nix lua vim.lsp.buf.format()
]],
	false
)
