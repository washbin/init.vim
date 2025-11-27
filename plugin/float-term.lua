local win, buf = nil, nil

local function toggleterm()
  -- Hide if open
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_hide(win)
    win = nil
    return
  end

  -- Create buffer if needed
  if not buf or not vim.api.nvim_buf_is_valid(buf) then buf = vim.api.nvim_create_buf(false, true) end

  -- Open window
  win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    row = math.floor(vim.o.lines * 0.1),
    col = math.floor(vim.o.columns * 0.1),
    border = 'rounded',
  })

  -- No statuscolumn in window
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = 'no'

  -- Start terminal if not running
  if vim.bo[buf].buftype ~= 'terminal' then vim.cmd.terminal() end -- vim.fn.termopen(vim.o.shell) end

  vim.cmd('startinsert')
end

vim.keymap.set({ 'n', 't' }, '<C-t>', toggleterm, { desc = 'Toggle floating terminal' })
