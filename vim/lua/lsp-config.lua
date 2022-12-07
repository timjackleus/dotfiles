-- manage icons
local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, {
		text = icon,
		numhl = hl,
		texthl = hl,
	})
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

local saga = require("lspsaga")

saga.init_lsp_saga({
	symbol_in_winbar = {
		in_custom = true,
	},
})

vim.keymap.set("n", "ge", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "[e", function()
	require("lspsaga.diagnostic").goto_prev()
end, { silent = true })
vim.keymap.set("n", "]e", function()
	require("lspsaga.diagnostic").goto_next()
end, { silent = true })

local lspconfig = require("lspconfig")

local function formatFile(bufnr)
	vim.lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end

local on_attach = function(_, bufnr)
	local opts = {
		buffer = bufnr,
	}
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, opts)
	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
	-- vim.keymap.set("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<cr>", { buffer = 0 })
	--
	vim.keymap.set("n", "<leader>fo", formatFile, { buffer = 0 })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Enable the following language servers
local servers = { "svelte", "gopls", "eslint", "angularls", "cssls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

require("lspconfig").denols.setup({
	-- Omitting some options
	root_dir = require("lspconfig").util.root_pattern("deno.json"),

	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").tsserver.setup({
	-- Omitting some options
	root_dir = require("lspconfig").util.root_pattern("package.json"),

	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").intelephense.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	intelephense = {
		stubs = {
			"Core",
			"wordpress",
			"woocommerce",
			"acf-pro",
			"wordpress-globals",
			"wp-cli",
		},
		environment = {
			includePaths = "/home/timjackleus/.composer/vendor/php-stubs/", -- this line forces the composer path for the stubs in case inteliphense don't find it...
		},
		files = {
			maxSize = 5000000,
		},
	},
})

require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			-- Disable this in favour of stylua
			format = { enable = false },
			diagnostics = {
				globals = {
					"vim",
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

require("null-ls").setup({
	debug = true,
	sources = {
		require("null-ls").builtins.diagnostics.eslint_d,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.eslint_d,
		require("null-ls").builtins.formatting.gofmt,
		require("null-ls").builtins.formatting.prettierd,
	},
	on_attach = function(client, bufnr)
		-- more info https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
-- Setup nvim-cmp.
vim.opt.completeopt = { "menu", "menuone", "noselect" }
