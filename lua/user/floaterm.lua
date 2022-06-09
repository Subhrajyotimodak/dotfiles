local status_ok, _ = pcall(require, "vim-floaterm")

-- if not status_ok then
--   return
-- end

local opts = {noremap = true, silent = false}
local keymap = vim.api.nvim_set_keymap

keymap("n", "tn", ":FloatermNew<CR>", opts)
keymap("n", "tt", ":FloatermToggle<CR>", opts)
keymap("n", "tk", ":FloatermKill<CR>", opts)
keymap("n", "th", ":FloatermPrev<CR>", opts)
keymap("n", "tl", ":FloatermNext<CR>", opts)
