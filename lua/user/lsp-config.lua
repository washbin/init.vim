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
		-- header = "",
		-- prefix = "",
	},
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<space>sm", vim.lsp.buf.document_symbol, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

require("mason").setup()
require("mason-lspconfig").setup()

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.diagnostics.eslint,

		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,

		null_ls.builtins.diagnostics.solhint,

		null_ls.builtins.formatting.stylua,

		null_ls.builtins.completion.spell,
	},

	on_attach = on_attach,
})

-- Add additional capabilities supported by nvim-cmp
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local lspconfig = require("lspconfig")

-- -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { "pyright", "eslint", "tsserver" }
-- for _, lsp in ipairs(servers) do
-- 	lspconfig[lsp].setup({
-- 		-- on_attach = my_custom_on_attach,
-- 		capabilities = capabilities,
-- 	})
-- end

-- local rt = require("rust-tools")
-- rt.setup({
-- 	server = {
-- 		on_attach = function(_, bufnr)
-- 			-- Hover actions
-- 			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
-- 			-- Code action groups
-- 			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
-- 		end,
-- 	},
-- })
-- require("clangd_extensions").setup()
-- require("lspconfig").jsonls.setup({
-- 	settings = {
-- 		json = {
-- 			schemas = require("schemastore").json.schemas(),
-- 			validate = { enable = true },
-- 		},
-- 	},
-- })
-- require("lspconfig").yamlls.setup({
-- 	settings = {
-- 		yaml = {
-- 			schemas = require("schemastore").yaml.schemas(),
-- 		},
-- 	},
-- })
