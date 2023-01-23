local masonPresent, mason = pcall(require, "mason")
if not masonPresent then
	return
end
local masonLspConfigPresent, lspconfig = pcall(require, "mason-lspconfig")
if not masonLspConfigPresent then
	return
end

mason.setup({})

lspconfig.setup({
	ensure_installed = { "sumneko_lua", "angularls", "gopls", "cssls", "tsserver", "svelte", "eslint", "emmet_ls" },
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})
