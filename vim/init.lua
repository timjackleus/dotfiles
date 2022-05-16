require('basics')
require('colors')
require('telescope-config')
require('mappings')
require('neogit-config')
require('lualine-config')
require('gitblame-config')
require('treesitter-config')
require('nvim-tree-config')

require('Comment').setup()

local use = require('packer').use

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim' }
	use { 'mhinz/vim-startify' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
	use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
	}
  use { 'christoomey/vim-system-copy' }
	use {"ellisonleao/glow.nvim"}
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
	use { 'tpope/vim-surround' }
	use { "catppuccin/nvim", as = "catppuccin" }
  use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use { 'windwp/nvim-spectre', requires = { {'nvim-lua/plenary.nvim'} } }
	use { "mattn/emmet-vim" }
	use { "f-person/git-blame.nvim" }
  use { 'nvim-telescope/telescope.nvim',
    	requires = {
				{'nvim-lua/plenary.nvim'},
				{ 'nvim-telescope/telescope-github.nvim' }
		}
  }
	use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
}
end)
