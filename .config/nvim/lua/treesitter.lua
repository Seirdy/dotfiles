require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnn',
			node_incremental = 'grn',
			scope_incremental = 'grc',
			scope_decremental = 'grm',
		}
	},
	ensure_installed = 'python',
	additional_vim_regex_highlighting = false,
}
local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.pandoc = "markdown" -- the someft filetype will use the python parser and queries.
