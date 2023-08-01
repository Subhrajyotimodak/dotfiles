local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
	vim.notify("neotree not found")
	return
end

local config = {
	close_if_last_window = true,
	enable_diagnostics = true,
	popup_border_style = "rounded",
	source_selector = {
		winbar = false,
		content_layout = "center",
	},
	default_component_configs = {
		indent = { padding = 0 },
		container = {
        enable_character_fade = true
    },
		icon = {
			folder_default = "",
			folder_open = "",
			folder_empty = "",
			folder_empty_open = "",
			default = "",
			symlink = "",
		},
		git_status = {
			symbols = {
				conflict = "",
				unstaged = "",
				staged = "S",
				unmerged = "",
				renamed = "➜",
				deleted = "",
				untracked = "U",
				ignored = "◌",
			},
		},
	},
	window = {
		width = 30,
		mappings = {
			["<space>"] = false, -- disable space until we figure out which-key disabling
			o = "open",
			--[[ O = function(state) astronvim.system_open(state.tree:get_node():get_id()) end, ]]
			H = "prev_source",
			L = "next_source",
			v = "toggle_node",
		},
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
		window = { mappings = { h = "toggle_hidden" } },
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(_)
				vim.opt_local.signcolumn = "auto"
			end,
		},
	},
}

neo_tree.setup(config)
