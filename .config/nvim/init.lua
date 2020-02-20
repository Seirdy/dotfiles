local nvim_lsp = require'nvim_lsp'
local util = require 'nvim_lsp/util'
nvim_lsp.bashls.setup{
	filetypes = { "sh", "zsh" }
}
nvim_lsp.ccls.setup{}
nvim_lsp.cssls.setup{
	root_dir = util.root_pattern("package.json",".git")
}
nvim_lsp.gopls.setup{}
nvim_lsp.dockerls.setup{}
nvim_lsp.ghcide.setup{}
nvim_lsp.jsonls.setup{}
nvim_lsp.vimls.setup{}
nvim_lsp.pyls.setup{
	settings = {
		pyls = {
			plugins = {
				mccabe = { enabled = false },
				pydocstyle = {
					enabled = true,
					convention = "numpy"
				},
				pylint = { enabled = false },
				black = { enabled = true },
			}
		}
	}
}
nvim_lsp.sumneko_lua.setup{}

local colorizer = require'colorizer'
colorizer.setup {
	'css',
	'javascript',
	'html',
	css = { rgb_fn = true }
}
