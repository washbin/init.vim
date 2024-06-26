vim.api.nvim_exec2(
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
	nnoremap <silent> <Leader>z :ZoomToggle<CR>
]],
  {}
)
