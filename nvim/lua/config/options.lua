-- Visual
vim.o.conceallevel       = 0                            -- Don't hide quotes in markdown
vim.o.cmdheight          = 1
vim.o.pumheight          = 10
vim.o.showmode           = false
vim.o.showtabline        = 2                            -- Always show tabline
vim.o.title              = true
vim.o.termguicolors      = true                         -- Use true colors, required for some plugins
-- vim.o.ls                 = 0                         -- Doesn't seem to work
-- vim.o.ch                 = 0                         -- Creates a bug with output messages not appearing correctly
vim.wo.number            = true
vim.wo.relativenumber    = true
vim.wo.signcolumn        = 'yes'
vim.wo.cursorline        = true
-- Behavior
vim.o.hlsearch           = false
vim.o.ignorecase         = true                         -- Ignore case when using lowercase in search
vim.o.smartcase          = true                         -- But don't ignore it when using upper case
vim.o.smarttab           = true
vim.o.smartindent        = true
vim.o.expandtab          = true                         -- Convert tabs to spaces.
vim.o.clipboard          = "unnamedplus"
vim.o.tabstop            = 4
-- vim.o.nocursorline       = false
-- vim.o.nocursorcolumn     = false
vim.o.scrolljump         = 5
vim.o.lazyredraw         = false
vim.o.redrawtime         = 10000
vim.o.synmaxcol          = 180
vim.o.re                 = 1
vim.o.softtabstop        = 4
vim.o.shiftwidth         = 4
vim.o.splitbelow         = true
vim.o.splitright         = true
vim.o.scrolloff          = 12                           -- Minimum offset in lines to screen borders
vim.o.sidescrolloff      = 8
vim.o.mouse              = 'a'
-- Vim specific
vim.o.hidden             = true                         -- Do not save when switching buffers
vim.o.fileencoding       = "utf-8"
vim.o.spell              = false                         -- As of v0.8.0 it only checks comments
vim.o.spelllang          = "en_us"
vim.o.completeopt        = "menuone,noinsert,noselect"
vim.o.wildmode           = "longest,full"               -- Display auto-complete in Command Mode
vim.o.updatetime         = 300                          -- Delay until write to Swap and HoldCommand event
vim.g.do_file_type_lua   = 1
-- Disable default plugins
-- vim.g.loaded_netrwPlugin = false                     -- I can't remember what the issue was with this option
--
-- Python providers
local pynvim_env        = os.getenv("HOME").."/.local/bin/pyenv/versions/pynvim/"
vim.g.python3_host_prog = os.getenv("HOME")..pynvim_env.."/bin/python"
vim.g.black_virtualenv  = os.getenv("HOME")..pynvim_env
-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- IdentLine
vim.g.indentLine_char_list = {'▏', '¦', '┆', '┊'}
vim.g.indentLine_setColors = 0
vim.g.indentLine_setConceal = 0
-- Enable inline error messages
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,          -- Keep gutter signs
}
