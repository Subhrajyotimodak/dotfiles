local status_ok, _ = pcall(require, "vim-floaterm")

-- if not status_ok then
--   return
-- end

local opts = {noremap = true, silent = false}
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-n>", ":FloatermNew<CR>", opts)
keymap("n", "<C-t>", ":FloatermToggle<CR>", opts)
keymap("n", "<C-k>", ":FloatermKill<CR>", opts)
keymap("n", "th", ":FloatermPrev<CR>", opts)
keymap("n", "tl", ":FloatermNext<CR>", opts)
