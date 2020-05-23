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
	ensure_installed = 'python'
}
