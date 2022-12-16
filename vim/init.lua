-- Install packer if not yet installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

require("basics")
require("mappings")
require("lsp-saga")
require("lsp-config")
require("null-ls-config")
require("hop-config")

require("nvim-autopairs").setup()
require("Comment").setup()
require("nvim-surround").setup()

local use = require("packer").use

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- common utilities, req by many plugins
	use("kyazdani42/nvim-web-devicons") -- File icons
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("nvim-treesitter/nvim-treesitter")
	use("TimUntersberger/neogit")
	use("numToStr/Comment.nvim")
	use("christoomey/vim-system-copy")
	use("ellisonleao/glow.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("nvim-lualine/lualine.nvim")
	use("windwp/nvim-spectre")
	use("ThePrimeagen/harpoon")
	-- use({ "mattn/emmet-vim" })
	use("f-person/git-blame.nvim")
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("lewis6991/gitsigns.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-telescope/telescope-github.nvim" },
		},
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"MunifTanjim/nui.nvim",
		},
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"L3MON4D3/LuaSnip",
		},
	})
	use("saadparwaiz1/cmp_luasnip")
	use("jose-elias-alvarez/null-ls.nvim")
	use("windwp/nvim-autopairs")
	use("lukas-reineke/lsp-format.nvim")
	use("rafamadriz/friendly-snippets")
	use({ "phaazon/hop.nvim", branch = "v2" })
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	})
	use({ "glepnir/lspsaga.nvim", branch = "main" })
end)
