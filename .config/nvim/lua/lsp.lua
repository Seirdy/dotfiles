local nvim_lsp = require'nvim_lsp'
local util = require 'nvim_lsp/util'
local api = vim.api

local custom_on_attach_diagnostics = function(_, bufnr)
  -- Mappings.

  local opts = {
		noremap=true,
		silent=true,
	}
	local function nmap_lsp(keys, cmd)
		api.nvim_buf_set_keymap(
			bufnr, 'n', keys, '<cmd>lua vim.lsp.'..cmd..'<CR>', opts
		)
	end
  nmap_lsp('D',     'util.show_line_diagnostics()')
	vim.g['diagnostic_enable_virtual_text'] = 1
	require'diagnostic'.on_attach()
end

local custom_on_attach = function(_, bufnr)
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.

  local opts = {
		noremap=true,
		silent=true,
	}
	local function nmap_lsp(keys, cmd)
		api.nvim_buf_set_keymap(
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
  nmap_lsp('pd',    'buf.peek_definition()')
  nmap_lsp('gr',    'buf.references()')
	vim.g['diagnostic_enable_virtual_text'] = 1
	-- api.nvim_set_var('diagnostic_enable_virtual_text','1')
	require'diagnostic'.on_attach()
	require'completion'.on_attach()
end

--  efm doesn't like being told to fold, so only fold on buffers that
--  don't have EFM but use an LSP server that supports folding.
local custom_on_attach_folding = function(_, bufnr)
	custom_on_attach(_, bufnr)
	require('folding').on_attach()
end

-- nvim_lsp.bashls.setup{
-- 	on_attach = custom_on_attach,
-- 	filetypes = { "sh", "zsh" }
-- }
nvim_lsp.ccls.setup{
	on_attach = custom_on_attach_folding,
}
nvim_lsp.html.setup{
	on_attach = custom_on_attach_folding,
}
nvim_lsp.cssls.setup{
	cmd = {"/home/rkumar/Executables/npm/bin/vscode-json-languageserver"},
	on_attach = custom_on_attach_folding,
	root_dir = util.root_pattern("package.json",".git")
}
nvim_lsp.gopls.setup{
	on_attach = custom_on_attach_folding,
	init_options = {
		linkTarget="pkg.go.dev",
		completionDocumentation=true,
		deepCompletion=true,
		fuzzyMatching=true
	}
}
nvim_lsp.dockerls.setup{
	on_attach = custom_on_attach_folding,
}
nvim_lsp.ghcide.setup{
	on_attach = custom_on_attach_folding,
}
nvim_lsp.jsonls.setup{
	on_attach = custom_on_attach_folding,
}
nvim_lsp.vimls.setup{
	on_attach = custom_on_attach
}
nvim_lsp.efm.setup{
	on_attach = custom_on_attach_diagnostics,
	-- only run on configured filetypes
	filetypes = {'pandoc', 'rst','sh','vim','make','yaml','dockerfile'},
}
nvim_lsp.jedi_language_server.setup{
	on_attach = custom_on_attach,
}
-- nvim_lsp.pyls_ms.setup{
-- 	on_attach = custom_on_attach_folding,
-- 	init_options = {
-- 		InterpreterPath = "/usr/bin/python3",
-- 		Version = "3.8",
-- 	},
-- 	settings = {
-- 		python = {
-- 			formatting = {
-- 				provider = 'black'
-- 			},
-- 			workspaceSymbols = {
-- 				enabled = true,
-- 			},
-- 			linting = {
-- 				enabled = true,
-- 				lintOnSave = true,
-- 				pylintEnabled = true,
-- 				flake8Enabled = true,
-- 				mypyEnabled = true,
-- 			},
-- 		},
-- 	},
-- }
-- nvim_lsp.pyls.setup{
-- 	on_attach = custom_on_attach,
-- 	settings = {
-- 		pyls = {
-- 			plugins = {
-- 				jedi_completion = { enabled = true },
-- 				jedi_symbols = {
-- 					enabled = true,
-- 					all_scopes = true,
-- 				},
-- 				mccabe = { enabled = false },
-- 				preload = { enabled = true },
-- 				pydocstyle = {
-- 					enabled = true,
-- 				},
-- 				pyflakes = { enabled = true },
-- 				pylint = { enabled = false },
-- 				rope_completion = { enabled = true },
-- 				black = { enabled = true },
-- 				isort = { enabled = true }
-- 			}
-- 		}
-- 	}
-- }
nvim_lsp.sumneko_lua.setup{
	on_attach = custom_on_attach_folding,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT"
			}
		}
	}
}
