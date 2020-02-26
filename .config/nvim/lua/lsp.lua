local nvim_lsp = require'nvim_lsp'
local util = require 'nvim_lsp/util'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.

  local opts = { noremap=true, silent=true }
	local function nmap_lsp(keys, cmd)
		vim.api.nvim_buf_set_keymap(
			bufnr, 'n', keys, '<cmd>lua vim.lsp.'..cmd..'<CR>', opts
		)
	end
	nmap_lsp('gd',    'buf.declaration()')
  nmap_lsp('<c-]>', 'buf.definition()')
	nmap_lsp('K',     'buf.hover()')
  nmap_lsp('D',     'util.show_line_diagnostics()')
  nmap_lsp('gi',    'util.implementation()')
  nmap_lsp('<C-k>', 'buf.signature_help()')
  nmap_lsp(',rn',   'buf.rename()')
  nmap_lsp('gy',    'buf.type_definition()')
  nmap_lsp('gr',    'buf.references()')
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