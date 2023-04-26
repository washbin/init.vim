local lsp = vim.lsp
lsp.handlers["textdocument/hover"] = lsp.with(lsp.handlers.hover, {
	border = "rounded",
})
lsp.handlers["textdocument/signaturehelp"] = lsp.with(lsp.handlers.signature_help, {
	border = "rounded",
})

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end
sign({ name = "diagnosticsignerror", text = "✘" })
sign({ name = "diagnosticsignwarn", text = "▲" })
sign({ name = "diagnosticsignhint", text = "⚑" })
sign({ name = "diagnosticsigninfo", text = "" })

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

-- use lspattach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("lspattach", {
	group = vim.api.nvim_create_augroup("userlspconfig", {}),
	callback = function(ev)
		-- enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- buffer local mappings.
		-- see `:help vim.lsp.*` for documentation on any of the below functions
		local keymap = function(mode, key, action, desc)
			local opts = { buffer = ev.buf, desc = desc }
			vim.keymap.set(mode, key, action, opts)
		end
		keymap("n", "gd", vim.lsp.buf.declaration, "go to declaration")
		keymap("n", "gd", vim.lsp.buf.definition, "go to definition")
		keymap("n", "K", vim.lsp.buf.hover, "show hover")
		keymap("n", "gi", vim.lsp.buf.implementation, "go to implementation")
		keymap("n", "<C-k>", vim.lsp.buf.signature_help, "show signature help")
		keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
		keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
		keymap("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "list workspace folders")
		keymap("n", "<space>d", vim.lsp.buf.type_definition, "go to type definition")
		keymap("n", "<space>rn", vim.lsp.buf.rename, "rename symbol")
		keymap("n", "<space>sm", vim.lsp.buf.document_symbol, "document symbols")
		keymap({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, "code action")
		keymap("n", "gr", vim.lsp.buf.references, "references")
		keymap("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, "format")

		keymap("n", "<space>e", vim.diagnostic.open_float, "show diagnostics")
		keymap("n", "[d", vim.diagnostic.goto_prev, "go to previous diagnostic")
		keymap("n", "]d", vim.diagnostic.goto_next, "go to next diagnostic")
		keymap("n", "<space>q", vim.diagnostic.setloclist, "set location list")
	end,
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
		"clangd",
		"jsonls",
		"yamlls",
		"tsserver",
		"pyright",
	},
})

-- add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
	["rust_analyzer"] = function()
		require("rust-tools").setup({
			server = {
				on_attach = function(_, bufnr)
					-- hover actions
					vim.keymap.set(
						"n",
						"<C-space>",
						rt.hover_actions.hover_actions,
						{ buffer = bufnr, desc = "show hover actions" }
					)
					-- code action groups
					vim.keymap.set(
						"n",
						"<leader>a",
						rt.code_action_group.code_action_group,
						{ buffer = bufnr, desc = "show code action groups" }
					)
				end,
			},
		})
	end,
	["clangd"] = function()
		require("clangd_extensions").setup()
	end,
	["jsonls"] = function()
		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end,
	["yamlls"] = function()
		require("lspconfig").yamlls.setup({
			settings = {
				yaml = {
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})
	end,
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.diagnostics.eslint,

		null_ls.builtins.code_actions.gitsigns,

		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,

		null_ls.builtins.diagnostics.solhint,

		null_ls.builtins.formatting.stylua,

		null_ls.builtins.completion.spell,
	},
	on_attach = on_attach,
})
