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

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
})

local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
	local opts = {
		buffer = bufnr,
	}
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, opts)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {
		buffer = 0,
	})
	vim.keymap.set("n", "]g", vim.diagnostic.goto_next, {
		buffer = 0,
	})
	vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, {
		buffer = 0,
	})
	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {
		buffer = 0,
	})
	vim.keymap.set("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", {
		buffer = 0,
	})

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local option = {
				focusable = false,
				close_events = {
					"BufLeave",
					"CursorMoved",
					"InsertEnter",
					"FocusLost",
				},
				border = "single",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, option)
		end,
	})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Enable the following language servers
local servers = { "svelte", "gopls", "eslint", "angularls" }
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
					})
				end,
			})
		end
	end,
})
-- Setup nvim-cmp.
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local luasnip = require("luasnip")

-- get custom snippets in vsc style
require("luasnip.loaders.from_vscode").lazy_load({
	paths = {
		"./snippets",
	},
})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			select = true,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", max_item_count = 5 },
		{ name = "luasnip", max_item_count = 5 },
		{ name = "path", max_item_count = 10 },
		{ name = "buffer", max_item_count = 5 },
	}),
})
