set relativenumber
set cursorline			" line with cursor is highlited
set mouse=a			" Enable mouse use
set clipboard+=unnamedplus	" Same clipboard for nvim and system


":command w q!

" clear seach higlights
nnoremap <leader>h :nohl<CR>

""" ii for escape
inoremap ii <Esc>

""" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

""" Resize split windows
nnoremap <C-up> <C-w>+
nnoremap <C-down> <C-w>-
nnoremap <C-left> <C-w>>
nnoremap <C-right> <C-w><

""" Moving lines up and down with alt j k in normal and visual
nnoremap <silent> <A-k> :m .-2<CR>==
nnoremap <silent> <A-j> :m .+1<CR>==
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

""" Indenting in visual mode persistence
vnoremap > >gv
vnoremap < <gv

""" Netrw with settings and Ctrl n for toggling
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=20
let g:netrw_list_hide=netrw_gitignore#Hide()
nnoremap <silent> <C-n> :Lexplore<CR>

""" Integrated terminal opens in insert mode and mapped to Ctrl t
set splitbelow
nnoremap <silent> <C-t> :split term://bash<CR> :set nornu<CR> :resize 15<CR> i

""" Set cursoline only in active window
augroup cursor_off
	autocmd!
	autocmd WinLeave * set nocursorline
	autocmd WinEnter * set cursorline
augroup END


"CRedit: Mahesh C. Regmi (Handsome Devops 20XX)
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


""" PLUGINS 
lua require('plugins')

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fe <cmd>Telescope file_browser<cr>

" auto-format
autocmd BufWritePre *.ts,*.tsx lua vim.lsp.buf.formatting()
autocmd BufWritePre *.js,*.jsx lua vim.lsp.buf.formatting()
autocmd BufWritePre *.py lua vim.lsp.buf.formatting()
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting()
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting()
