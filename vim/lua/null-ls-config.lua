local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
		timeout_ms = 2000,
	})
end

null_ls.setup({
	debug = true,
	sources = {
		require("null-ls").builtins.diagnostics.eslint_d,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.eslint_d,
		require("null-ls").builtins.formatting.gofmt,
		require("null-ls").builtins.formatting.prettierd.with({
			filetypes = { "svelte", "html", "css", "typescript" },
		}),
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
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
