-- Load all config files
require "user.options"
require "user.plugins"
require "user.commands"
require "user.keymaps"
-- require "user.illuminate"
require "user.vscode.hop"

if vim.g.vscode then
    -- VSCode extension
    require "user.vscode.vscode-keymap"
else
    require "user.terminal.keymaps"
	require "user.themes"
end
