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
		run = ':cocInstall coc-css coc-eslint coc-explorer coc-go coc-highlight coc-html coc-json coc-lua coc-pairs coc-prettier coc-snippets coc-svelte coc-tsserver coc-yaml'

	}
  use 'folke/tokyonight.nvim'
	use 'navarasu/onedark.nvim'
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
				{ "nvim-telescope/telescope-github.nvim" }
		}
  }
  use {
    "blackCauldron7/surround.nvim",
    config = function()
      require"surround".setup {mappings_style = "surround"}
    end
  }
  use {
    'windwp/nvim-spectre',
    	requires = {
				{'nvim-lua/plenary.nvim'}
		}
  }
end)

