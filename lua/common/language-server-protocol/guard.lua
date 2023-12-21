local ft_status_ok, ft = pcall(require, "guard.filetype")
if not ft_status_ok then
	vim.notify("guard.filetype is not installed :(")
	return
end

local guard_status_ok, guard = pcall(require, "guard")
if not guard_status_ok then
	vim.notify("guard is not installed :(")
	return
end

ft("lua"):fmt("lsp"):append("stylua")

ft("typescript,javascript,typescriptreact,svelte"):fmt("prettier"):lint("eslint_d")

ft("python"):fmt("black"):lint("pyright")

guard.setup({
	-- the only options for the setup function
	fmt_on_save = true,
	-- Use lsp if no formatter was defined for this filetype
	lsp_as_default_formatter = false,
})
