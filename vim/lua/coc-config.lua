vim.cmd [[
	let g:coc_explorer_global_presets = {
	\   'floating': {
	\      'position': 'floating',
	\   }
	\ }
]]

vim.cmd [[
	command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
	command! -nargs=0 CocPrettier :CocCommand prettier.formatFile
]]

