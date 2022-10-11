if (vim.g.neovide) then
	require "neovide"
	return
end

if (vim.g.vscode) then
	require "vscode"
	return
end

require "terminal"
