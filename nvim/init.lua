-- Load all config files
require "options"
require "commands"
require "keymaps"

if vim.g.vscode then
    -- VSCode extension
    require "vscode.plugins"
    require "vscode.vscode-keymap"
else
	require "plugins"
    require "themes"
end

require "vscode.hop"
