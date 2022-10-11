local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "common.lsp.configs"
require("common.lsp.handlers").setup()
require "common.lsp.null-ls"
