-- Load all config files
-- require "user.illuminate"
local dir = os.getenv("DOTFILES") .. "/nvim/lua/?.lua"
package.path = package.path .. ";" .. dir

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
