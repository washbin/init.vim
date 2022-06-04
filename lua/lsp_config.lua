local opts = { noremap = true, silent = true }
local function set_keymap(...)
  vim.api.nvim_set_keymap("n", ...)
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
set_keymap("<space>e", "<cmd>lua vim.diagnostic.open_float(0, {scope='line',border='single'})<CR>", opts)
set_keymap("[d", "<cmd>lua vim.diagnostic.goto_prev({float={border='single'}})<CR>", opts)
set_keymap("]d", "<cmd>lua vim.diagnostic.goto_next({float={border='single'}})<CR>", opts)
set_keymap("<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, "n", ...)
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("<space>sm", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)

  -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup LSP
require("nvim-lsp-installer").on_server_ready(function(server)
  if server.name == "tsserver" then
    server:setup({
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    })
  else
    server:setup({ on_attach = on_attach, capabilities = capabilities })
  end
end)

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier,

    null_ls.builtins.diagnostics.flake8,
    -- null_ls.builtins.diagnostics.pyproject_flake8,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,

    null_ls.builtins.diagnostics.solhint,
  },
  on_attach = on_attach,
})
