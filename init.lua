-- Load all config files
require "user.options"
require "user.plugins"
require "user.commands"
require "user.keymaps"
-- require "user.illuminate"

if vim.g.vscode then
    -- VSCode extension
    require "user.vscode.vscode-keymap"
    require "user.vscode.hop"
    require "user.vscode.options"
else
    require "user.terminal.keymaps"
	require "user.themes"
end