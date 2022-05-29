local present, null_ls = pcall(require, "null-ls")

if not present then
   return
end

local present2, prettier = pcall(require, "prettier")

if not present2 then
   return
end

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      -- vim.cmd("nnoremap <silent><buffer> <Leader>fp :lua vim.lsp.buf.formatting()<CR>")
			vim.api.nvim_set_keymap("n", "<leader>fp", "", {
				noremap = true,
				callback = function()
					vim.lsp.buf.formatting();
				end,
			})
      -- format on save
			-- callback = function()
      -- vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "*",
				callback = function(args)
						print("Entered buffer " .. args.buf .. "!")
						vim.lsp.buf.formatting();
				end,
				desc = "Tell me when I enter a buffer",
			})
    end

    if client.resolved_capabilities.document_range_formatting then
      vim.cmd("xnoremap <silent><buffer> <Leader>fp :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})

prettier.setup({
  bin = 'prettier', -- or `prettierd`
  filetypes = {
		"svelte",
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },

  -- prettier format options (you can use config files too. ex: `.prettierrc`)
  arrow_parens = "avoid",
  bracket_spacing = true,
  embedded_language_formatting = "auto",
  end_of_line = "lf",
  html_whitespace_sensitivity = "css",
  jsx_bracket_same_line = false,
  jsx_single_quote = false,
  print_width = 100,
  prose_wrap = "preserve",
  quote_props = "as-needed",
  semi = true,
  single_quote = true,
  tab_width = 2,
  trailing_comma = "all",
  use_tabs = true,
})
