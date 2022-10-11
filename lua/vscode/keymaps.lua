local opts = {noremap = true, silent= true}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window Navigation
keymap("n", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
keymap("n", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
keymap("n", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
keymap("n", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)
-- Navigate Buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- toggle file tree
keymap("", "<leader>e", ":call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>", opts)

-- comment
keymap("n", "gcc", ":call VSCodeNotify('editor.action.commentLine')<CR>", opts)
-- keymap("x", "gc", ":call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>", opts)
keymap("x", "gc", ":call VSCodeCallVisual('editor.action.blockComment', 0)<CR>", opts)

