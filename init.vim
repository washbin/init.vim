set number
set relativenumber
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
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

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

""" Nvim Tree settings begin """
let g:nvim_tree_gitignore = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_disable_window_picker = 1
let g:nvim_tree_icon_padding = ' '
let g:nvim_tree_symlink_arrow = ' >> '
let g:nvim_tree_respect_buf_cwd = 1
let g:nvim_tree_create_in_closed_folder = 0
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
set termguicolors " this variable must be enabled for colors to be applied properly
highlight NvimTreeFolderIcon guibg=blue
""" Nvim Tree settings end """

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
autocmd BufWritePre *.html,*.css lua vim.lsp.buf.formatting()
autocmd BufWritePre *.py lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting()
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting()

