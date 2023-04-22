local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
	return
end

_G.copilot = copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

local keymap = vim.api.nvim_set_keymap
keymap("i", "<leader-j>", "<Plug>(copilot-next)", { silent = true })
keymap("i", "<leader-k>", "<Plug>(copilot-previous)", { silent = true })
keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)", { silent = true })
keymap("i", "mm", "<Cmd>v:lua.copilot.accept()<Cr>", { silent = true })
