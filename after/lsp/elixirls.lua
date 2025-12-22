---@type vim.lsp.Config
return {
  cmd = { vim.fn.expand('$HOME/.elixir-ls/language_server.sh') },
  settings = {
    enableTestLenses = true,
    dialyzerEnabled = true,
    suggestSpecs = true,
  },
}
