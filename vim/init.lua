-- Install packer if not yet installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

require("basics")
require("colors")
require("telescope-config")
require("mappings")
require("neogit-config")
require("lualine-config")
require("gitblame-config")
require("treesitter-config")
require("neotree-config")
require("lsp-installer-config") -- must be called before lsp-config
require("lsp-config")
require("gitsigns-config")
require("hop-config")

require("nvim-autopairs").setup()
require("Comment").setup()
require("nvim-surround").setup()

local use = require("packer").use

return require("packer").startup(function()
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use({ "numToStr/Comment.nvim" })
	use({ "christoomey/vim-system-copy" })
	use({ "ellisonleao/glow.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
	use({ "windwp/nvim-spectre", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "ThePrimeagen/harpoon", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "mattn/emmet-vim" })
	use({ "f-person/git-blame.nvim" })
	use({ "neovim/nvim-lspconfig" })
	use({ "lewis6991/gitsigns.nvim" })
	use({ "williamboman/nvim-lsp-installer" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-github.nvim" },
		},
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
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
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "windwp/nvim-autopairs" })
	use({ "lukas-reineke/lsp-format.nvim" })
	use({ "rafamadriz/friendly-snippets" })
	use({
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
	})
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
end)
