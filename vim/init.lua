require('basics')
require('colors')
require('telescope-config')
require('mappings')
require('neogit-config')
require('lualine-config')
require('gitblame-config')
require('treesitter-config')
require('nvim-tree-config')
require('lsp-installer-config') -- must be called before lsp-config
require('lsp-config')
require('gitsigns-config')

require('nvim-autopairs').setup();
require('Comment').setup()

local use = require('packer').use

return require('packer').startup(function()
	use { 'wbthomason/packer.nvim' }
	use { 'mhinz/vim-startify' }
	use { 'nvim-treesitter/nvim-treesitter' }
	use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
	use { 'numToStr/Comment.nvim' }
	use { 'christoomey/vim-system-copy' }
	use { 'ellisonleao/glow.nvim' }
	use { 'JoosepAlviste/nvim-ts-context-commentstring' }
	use { 'tpope/vim-surround' }
	use { 'catppuccin/nvim', as = 'catppuccin' }
	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
	use { 'windwp/nvim-spectre', requires = { { 'nvim-lua/plenary.nvim' } } }
	use { 'mattn/emmet-vim' }
	use { 'f-person/git-blame.nvim' }
	use { 'neovim/nvim-lspconfig' }
	use { 'lewis6991/gitsigns.nvim' }
	use {
		"williamboman/nvim-lsp-installer",
	}
	use { 'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-github.nvim' }
		}
	}
	use { 'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
	use { 'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-path', 'hrsh7th/cmp-emoji', 'L3MON4D3/LuaSnip'
		}
	}
	use { 'tzachar/cmp-tabnine',
		run = './install.sh',
		requires = 'hrsh7th/nvim-cmp'
	}
	use { 'jose-elias-alvarez/null-ls.nvim' }
	use { 'windwp/nvim-autopairs' }
	use { "lukas-reineke/lsp-format.nvim" }
	-- use {
	-- 	"folke/trouble.nvim",
	-- 	requires = "kyazdani42/nvim-web-devicons",
	-- 	config = function()
	-- 		require("trouble").setup {
	-- 			-- your configuration comes here
	-- 			-- or leave it empty to use the default settings
	-- 			-- refer to the configuration section below
	-- 		}
	-- 	end
	-- }
end)
