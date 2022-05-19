require'nvim-treesitter.configs'.setup {
  ensure_installed = {
		'bash',
		'css',
		'dockerfile',
		'fish',
		'go',
		'html',
		'http',
		'javascript',
		'jsdoc',
		'json',
		'lua',
		'python',
		'rust',
		'scss',
		'svelte',
		'tsx',
		'typescript',
		'vim',
		'yaml'
	},
  context_commentstring = {
    enable = true
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}
