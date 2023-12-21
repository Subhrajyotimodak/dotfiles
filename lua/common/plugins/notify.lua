local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

local config = {
	fps = 120,
	max_width = 60,
	render = "wrapped-compact",
	on_open = function(win)
		--[[ vim.api.nvim_win_set_config(win, { zindex = 175 }) ]]
		--[[ if not vim.g.ui_notifications_enabled then ]]
		--[[ 	vim.api.nvim_win_close(win, true) ]]
		--[[ end ]]
		if not package.loaded["nvim-treesitter"] then
			require("treesitter")
		end
		--[[ vim.wo[win].conceallevel = 3 ]]
		local buf = vim.api.nvim_win_get_buf(win)
		if not pcall(vim.treesitter.start, buf, "markdown") then
			vim.bo[buf].syntax = "markdown"
		end
		--[[ vim.wo[win].spell = false ]]
	end,
}

notify.setup(config)
vim.notify = notify
