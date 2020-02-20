local nvim_lsp = require'nvim_lsp'
local util = require 'nvim_lsp/util'
local buf_set_keymap = vim.api.nvim_buf_set_keymap
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.

  local opts = { noremap=true, silent=true }
  buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'D', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.util.implementation()<CR>', opts)
  buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap(bufnr, 'n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

nvim_lsp.bashls.setup{
	on_attach = on_attach,
	filetypes = { "sh", "zsh" }
}
nvim_lsp.ccls.setup{}
nvim_lsp.cssls.setup{
	on_attach = on_attach,
	root_dir = util.root_pattern("package.json",".git")
}
nvim_lsp.gopls.setup{
	on_attach = on_attach
}
nvim_lsp.dockerls.setup{
	on_attach = on_attach
}
nvim_lsp.ghcide.setup{
	on_attach = on_attach
}
nvim_lsp.jsonls.setup{
	on_attach = on_attach
}
nvim_lsp.vimls.setup{
	on_attach = on_attach
}
nvim_lsp.pyls.setup{
	on_attach = on_attach,
	settings = {
		pyls = {
			plugins = {
				jedi_completion = { enabled = true },
				jedi_symbols = {
					enabled = true,
					all_scopes = true,
				},
				mccabe = { enabled = false },
				preload = { enabled = true },
				pydocstyle = {
					enabled = true,
				},
				pyflakes = { enabled = true },
				pylint = { enabled = false },
				rope_completion = { enabled = true },
				black = { enabled = true },
			}
		}
	}
}
nvim_lsp.sumneko_lua.setup{
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT"
			}
		}
	}
}

local colorizer = require'colorizer'
colorizer.setup {
	'css',
	'javascript',
	'html',
	css = { rgb_fn = true }
}
