-- Load all config files
require "user.plugins"
require "user.options"
require "user.commands"
require "user.keymaps"
require "user.themes"
require "user.illuminate"


if vim.g.vscode then
  -- VSCode extension
  require "user.vscode"
else
    require "user.plugins"
    require "user.options"
    require "user.commands"
    require "user.keymaps"
    requier "user.themes"
end