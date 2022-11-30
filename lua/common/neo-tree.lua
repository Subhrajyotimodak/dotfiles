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
		winbar = true,
		content_layout = "center",
		tab_labels = {
			--[[ filesystem = astronvim.get_icon "FolderClosed" .. " File", ]]
			--[[ buffers = astronvim.get_icon "DefaultFile" .. " Bufs", ]]
			--[[ git_status = astronvim.get_icon "Git" .. " Git", ]]
			--[[ diagnostics = astronvim.get_icon "Diagnostic" .. " Diagnostic", ]]
		},
	},
	default_component_configs = {
		indent = { padding = 0 },
		icon = {
			--[[ folder_closed = astronvim.get_icon "FolderClosed", ]]
			--[[ folder_open = astronvim.get_icon "FolderOpen", ]]
			--[[ folder_empty = astronvim.get_icon "FolderEmpty", ]]
			--[[ default = astronvim.get_icon "DefaultFile", ]]

			folder_default = "",
			folder_open = "",
			folder_empty = "",
			folder_empty_open = "",
			default = "",
			symlink = "",
		},
		git_status = {
			symbols = {
				conflict  = "",
				unstaged  = "",
				staged    = "S",
				unmerged  = "",
				renamed   = "➜",
				deleted   = "",
				untracked = "U",
				ignored   = "◌",
				--[[ added = astronvim.get_icon "GitAdd", ]]
				--[[ deleted = astronvim.get_icon "GitDelete", ]]
				--[[ modified = astronvim.get_icon "GitChange", ]]
				--[[ renamed = astronvim.get_icon "GitRenamed", ]]
				--[[ untracked = astronvim.get_icon "GitUntracked", ]]
				--[[ ignored = astronvim.get_icon "GitIgnored", ]]
				--[[ unstaged = astronvim.get_icon "GitUnstaged", ]]
				--[[ staged = astronvim.get_icon "GitStaged", ]]
				--[[ conflict = astronvim.get_icon "GitConflict", ]]
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
			v = "toggle_node"
		},
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
		window = { mappings = { h = "toggle_hidden" } },
	},
	event_handlers = {
		{ event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
	},
}

neo_tree.setup(config)
