local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end
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
	vim.keymap.set("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<cr>", { buffer = 0 })
	--
	vim.keymap.set("n", "<leader>fo", formatFile, { buffer = 0 })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Enable the following language servers
local servers = { "svelte", "gopls", "eslint", "cssls", "emmet_ls", "angularls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.tsserver.setup({
	-- Omitting some options
	root_dir = lspconfig.util.root_pattern("package.json"),

	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.intelephense.setup({
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

lspconfig.sumneko_lua.setup({
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
