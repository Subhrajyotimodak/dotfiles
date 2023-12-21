-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
	vim.notify("lualine is not installed :(")
	return
end

local macchiato = require("catppuccin.palettes").get_palette("macchiato")

-- get lualine nightfly theme
local lualine_nightfly = require("lualine.themes.nightfly")

-- new colors for theme
local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
}

-- change nightlfy theme colors
lualine_nightfly.normal.a.bg = macchiato.sky
lualine_nightfly.insert.a.bg = macchiato.teal
lualine_nightfly.visual.a.bg = macchiato.pink
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = macchiato.yellow,
		fg = macchiato.base, -- black
	},
}

-- configure lualine with modified theme
lualine.setup({
	options = {
		theme = lualine_nightfly,
	},
})
