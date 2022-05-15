vim.cmd [[
	let g:python3_host_prog = expand('/opt/homebrew/opt/python@3.10/bin/python3.10')
]]

require('basics')
require('colors')
require('telescope-config')
require('coc-config')
require('mappings')
require('neogit-config')
require('lualine-config')
require('gitblame-config')
require('treesitter-config')

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
  use { 'neoclide/coc.nvim',
		branch = 'release',
		run = ':CocInstall coc-css coc-eslint coc-explorer coc-go coc-highlight coc-html coc-json coc-lua coc-pairs coc-prettier coc-snippets coc-svelte coc-tsserver coc-yaml coc-emmet'
	}
  use { 'nvim-telescope/telescope.nvim',
    	requires = {
				{'nvim-lua/plenary.nvim'},
				{ 'nvim-telescope/telescope-github.nvim' }
		}
  }
end)
