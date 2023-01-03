local opts = { noremap = true, silent = true }
local function set_keymap(...)
  vim.keymap.set("n", ...)
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
set_keymap("<space>e", function() vim.diagnostic.open_float(0, {scope='line',border='single'}) end, opts)
set_keymap("[d", function() vim.diagnostic.goto_prev({float={border='rounded'}}) end, opts)
set_keymap("]d", function() vim.diagnostic.goto_next({float={border='rounded'}}) end, opts)
set_keymap("<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local function buf_set_keymap(...)
    vim.keymap.set("n", ...)
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("<space>D", vim.lsp.buf.type_definition, opts)
  buf_set_keymap("gD", vim.lsp.buf.declaration, opts)
  buf_set_keymap("gd", vim.lsp.buf.definition, opts)
  buf_set_keymap("gi", vim.lsp.buf.implementation, opts)
  buf_set_keymap("gr", vim.lsp.buf.references, opts)
  buf_set_keymap("K", vim.lsp.buf.hover, opts)
  buf_set_keymap("<C-k>", vim.lsp.buf.signature_help, opts)
  buf_set_keymap("<space>rn", vim.lsp.buf.rename, opts)
  buf_set_keymap("<space>ca", vim.lsp.buf.code_action, opts)
  buf_set_keymap("<space>sm", vim.lsp.buf.document_symbol, opts)

  buf_set_keymap("<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  buf_set_keymap("<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  buf_set_keymap("<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap("<space>f", function() vim.lsp.buf.format{ async = true } end, opts)
  elseif client.server_capabilities.documentRangeFormattingProvider then
    buf_set_keymap("<space>f", function() vim.lsp.buf.range_format{ async = true } end, opts)
  end

  if client.server_capabilities.document_highlight then
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
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local formatting_disabled_servers = {
  ["tsserver"] = true,
  ["html"] = true,
}
-- Setup LSP
require("nvim-lsp-installer").on_server_ready(function(server)
  if formatting_disabled_servers[server.name] then
    server:setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
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

local lsp = vim.lsp
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
  border = "rounded",
})
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
  border = "rounded",
})

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = "",
  })
end
sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
