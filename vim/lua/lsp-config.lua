  -- Setup lspconfig.
local present, cmpNvimLsp = pcall(require, "cmp_nvim_lsp")

if not present then
   return
end

local capabilities = cmpNvimLsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local null_ls = require('null-ls')
local lsp_format = require('lsp-format')

lsp_format.setup {
  javascript = {
    indent_width = 2,
    order = { 'eslint', 'null-ls' }
  },
  typescript = {
    indent_width = 2,
    order = { 'eslint', 'null-ls' }
  },
  html = {
    indent_width = 2
  }
}

local on_attach = function (client, bufnr)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
	vim.keymap.set("n", "[g", vim.diagnostic.goto_next, { buffer = 0 })
	vim.keymap.set("n", "]g", vim.diagnostic.goto_prev, { buffer = 0 })
	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })

	lsp_format.on_attach(client)
end

	-- Lua setup
-- brew install lua-language-server
require'lspconfig'.sumneko_lua.setup {
	capabilities = capabilities;
	on_attach = on_attach;
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'},
			},
		},
	},
}

	-- Null-ls setup
require'null-ls'.setup({
  sources = {
    null_ls.builtins.formatting.prettierd
  },
  on_attach = on_attach
})

-- tsserver
-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{
	capabilities = capabilities;
	on_attach = on_attach;
}

-- Svelte setup
-- npm install -g svelte-language-server
require'lspconfig'.svelte.setup{
	capabilities = capabilities;
	on_attach = on_attach;
}

-- Golang setup
require'lspconfig'.gopls.setup{
	capabilities = capabilities;
	on_attach = on_attach
}

 -- Setup nvim-cmp.
vim.opt.completeopt = {"menu", "menuone", "noselect"}

local cmp = require'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'luasnip' },
	 	{ name = 'buffer', keyword_length = 5  },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})


-- local present, lsp = pcall(require, "lsp")

-- brew install gopls

-- if not present then
--    return
-- end

-- lsp.gopls.setup {}

-- lsp.setup {
--
-- }
