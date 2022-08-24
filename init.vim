set number
" set relativenumber		" show's line number relative to current line
set cursorline			" line with cursor is highlited
set mouse=a			" Enable mouse use
set clipboard+=unnamedplus	" Same clipboard for nvim and system

" clear seach higlights
nnoremap <leader>h :nohl<CR>

""" ii for escape
inoremap ii <Esc>

""" Resize split windows
nnoremap <C-up> <C-w>+
nnoremap <C-down> <C-w>-
nnoremap <C-left> <C-w>>
nnoremap <C-right> <C-w><

""" Moving lines up and down with alt j k in normal and visual
nnoremap <silent> <A-k> :m .-2<CR>==
nnoremap <silent> <A-j> :m .+1<CR>==
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv

""" Indenting in visual mode persistence
vnoremap > >gv
vnoremap < <gv

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


""" PLUGINS 
lua require('plugins')

" NvimTree
set termguicolors " this variable must be enabled for colors to be applied properly
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" Tree-sitter based folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" Experimental -> hit zx if breaks, fold with za

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Copilot keybind
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" TagBar
nnoremap <leader>tg <cmd>TagbarToggle<CR>

" auto-format
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.h lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.cpp lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.hpp lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync()

set foldlevel=99
