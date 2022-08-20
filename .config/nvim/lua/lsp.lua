local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
-- local lsp_status = require('lsp-status')
local api = vim.api

-- lsp_status.register_progress()

local custom_on_attach = function(client, bufnr)
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
  nmap_lsp(']d',    'diagnostic.goto_next()')
  nmap_lsp('[d',    'diagnostic.goto_prev()')
  nmap_lsp('<leader>do',    'diagnostic.set_loclist()')
	-- api.nvim_set_var('diagnostic_enable_virtual_text','1')
	require'completion'.on_attach()
	-- lsp_status.on_attach(client)
end

--  efm doesn't like being told to fold, so only fold on buffers that
--  don't have EFM but use an LSP server that supports folding.
local custom_on_attach_folding = function(client, bufnr)
	custom_on_attach(client, bufnr)
	require('folding').on_attach()
end

lspconfig.ccls.setup{
	on_attach = custom_on_attach_folding,
}
lspconfig.html.setup{
	on_attach = custom_on_attach_folding,
}
lspconfig.cssls.setup{
	cmd = {"/home/rkumar/Executables/npm/bin/vscode-json-languageserver"},
	on_attach = custom_on_attach_folding,
	root_dir = util.root_pattern("package.json",".git")
}
lspconfig.gopls.setup{
	on_attach = custom_on_attach_folding,
	init_options = {
		gofumpt = true,
		linkTarget="godocs.io",
		linksInHover=false,
		completionDocumentation=true,
		deepCompletion=true,
		matcher="fuzzy"
	}
}
lspconfig.dockerls.setup{
	on_attach = custom_on_attach_folding,
}
lspconfig.ghcide.setup{
	on_attach = custom_on_attach_folding,
}
lspconfig.jsonls.setup{
	on_attach = custom_on_attach_folding,
}
lspconfig.vimls.setup{
	on_attach = custom_on_attach
}
-- lspconfig.efm.setup{
-- 	on_attach = custom_on_attach,
-- 	-- only run on configured filetypes
-- 	filetypes = {'rst','sh','vim','make','yaml','dockerfile'},
-- }
-- lspconfig.jedi_language_server.setup{
-- 	on_attach = custom_on_attach,
-- }
-- lspconfig.pyright.setup{
-- 	on_attach=custom_on_attach,
-- }
local custom_on_attach_nlua = function(client, bufnr)
	custom_on_attach_folding(client, bufnr)
end
require('nlua.lsp.nvim').setup(lspconfig, {
	on_attach = custom_on_attach_nlua,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT"
			}
		}
	}
})
