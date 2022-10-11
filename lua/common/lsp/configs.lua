local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = {
  "cssls",
  "dartls",
  "emmet_ls",
  "eslint",
  -- "grammarly",
  "jdtls",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "stylelint_lsp",
  "sumneko_lua",
  "tsserver",
  "zk",
	"solargraph",
	"sorbet",
	"svelte"
}

lsp_installer.setup {
  ensure_installed = servers
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("common.lsp.handlers").on_attach,
    capabilities = require("common.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "common.lsp.settings." ..server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end