-- Load all config files
-- require "user.illuminate"
require "user.options"
require "user.commands"
require "user.keymaps"

if vim.g.vscode then
    -- VSCode extension
    require "user.vscode.plugins"
    require "user.vscode.vscode-keymap"
else
	require "user.plugins"
    require "user.terminal.keymaps"
    require "user.themes"
end

require "user.vscode.hop"
