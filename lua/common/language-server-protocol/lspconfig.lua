-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	vim.notify("lspconfig is not installed :(")
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	vim.notify("cmp_nvim_lsp is not installed :(")
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	vim.notify("typescript is not installed :(")
	return
end

local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
	vim.notify("flutter-tools not installed")
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)                         -- show definition, references
	keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)                -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>Lspsaga finder imp<CR>", opts)                     -- go to implementation
	keymap.set("n", "<leader>t", "<cmd>Lspsaga code_action<CR>", opts)             -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                 -- smart rename
	keymap.set("n", "<leader>x", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
	keymap.set("n", "<leader>xx", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)                 -- see outline on right hand side
	keymap.set("n", "<leader>q", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

	--[[ keymap.set("n", "gdd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)                   -- got to declaration ]]
	--[[ keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)                     -- see definition and make edits in window ]]
	--[[ keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)                 -- go to implementation ]]
	--[[ keymap.set("n", "<leader>t", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)             -- see available code actions ]]
	--[[ keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)                 -- smart rename ]]
	--[[ keymap.set("n", "<leader>x", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)           -- show  diagnostics for line ]]
	--[[ keymap.set("n", "<leader>xx", "<cmd>lua vim.lsp.buf.show_cursor_diagnostics()<CR>", opts) -- show diagnostics for cursor ]]
	--[[ keymap.set("n", "[d", "<cmd>lua vim.lsp.buf.diagnostic_jump_prev()<CR>", opts)           -- jump to previous diagnostic in buffer ]]
	--[[ keymap.set("n", "]d", "<cmd>lua vim.lsp.buf.diagnostic_jump_next()<CR>", opts)           -- jump to next diagnostic in buffer ]]
	--[[ keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                           -- see outline on right hand side ]]
	--[[ keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) ]]

	--[[ keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)                           -- show documentation for what is under cursor ]]
	--[[ keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                           -- see outline on right hand side ]]
	--[[ keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) ]]

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")    -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>")  -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure svelte server
lspconfig["svelte"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "svelte", "html" },
})

-- json ls
lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false,           -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true,       -- fall back to standard LSP definition on failure
	},
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "typescript", "typescriptreact" },
	},
})

flutter_tools.setup({
	lsp = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure go server
lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure python server
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
