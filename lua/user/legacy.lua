vim.api.nvim_exec(
	[[
    """ Integrated terminal opens in insert mode and mapped to Ctrl t
    set splitbelow
    nnoremap <silent> <C-t> :split term://bash<CR> :set nonu<CR> :set nornu<CR> :resize 15<CR> i

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
]],
	false
)
