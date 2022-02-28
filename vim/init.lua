vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

require('treesitter-config')
require('basics')
require('colors')
require('telescope-config')
require('coc-config')
require('mappings')
require('neogit-config')
require('lualine-config')

local use = require('packer').use

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
		'neoclide/coc.nvim',
		branch = 'release',
		run = ':CocInstall coc-css coc-eslint coc-explorer coc-go coc-highlight coc-html coc-json coc-lua coc-pairs coc-prettier coc-snippets coc-svelte coc-tsserver coc-yaml coc-emmet'
	}
	use({
	"catppuccin/nvim",
		as = "catppuccin"
	})
	use 'mhinz/vim-startify'
  use 'nvim-treesitter/nvim-treesitter'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use 'tpope/vim-commentary'
  use 'christoomey/vim-system-copy'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    'nvim-telescope/telescope.nvim',
    	requires = {
				{'nvim-lua/plenary.nvim'},
				{ 'nvim-telescope/telescope-github.nvim' }
		}
  }
	-- use { 'echasnovski/mini.nvim', branch = 'stable' }
  use {
    'windwp/nvim-spectre',
    	requires = {
				{'nvim-lua/plenary.nvim'}
		}
  }
end)
