-- Visual
-- vim.o.guicursor = 'n-v-c-i:'
vim.opt.guicursor = {
  'n-c-v-sm:block-Cursor/lCursor-blinkon0',
  'i-ci-ve:ver10',
}
vim.o.conceallevel = 0 -- Don't hide quotes in markdown
vim.o.cmdheight = 1
vim.o.pumheight = 10
vim.o.showmode = false
vim.o.showtabline = 0      -- Always show tabline
vim.o.title = true
vim.o.termguicolors = true -- Use true colors, required for some plugins
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.cursorline = true
-- Behavior
vim.o.hlsearch = false
vim.o.ignorecase = true -- Ignore case when using lowercase in search
vim.o.smartcase = true  -- But don't ignore it when using upper case
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true -- Convert tabs to spaces.
vim.o.clipboard = 'unnamedplus'
vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection primary",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection primary -o",
  },
  cache_enabled = 1,
}
vim.o.tabstop = 4
-- vim.o.nocursorline       = false
-- vim.o.nocursorcolumn     = false
vim.o.scrolljump = 5
vim.o.lazyredraw = false
vim.o.redrawtime = 10000
vim.o.synmaxcol = 180
vim.o.re = 0
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 12 -- Minimum offset in lines to screen borders
vim.o.sidescrolloff = 8
vim.o.mouse = 'a'
-- Vim specific
vim.o.hidden = true -- Do not save when switching buffers
vim.o.fileencoding = 'utf-8'
vim.o.spell = false -- As of v0.8.0 it only checks comments
vim.o.spelllang = 'en_us'
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.wildmode = 'longest,full' -- Display auto-complete in Command Mode
vim.o.updatetime = 300          -- Delay until write to Swap and HoldCommand event
vim.g.do_file_type_lua = 1
-- Disable default plugins
-- vim.g.loaded_netrwPlugin = false                     -- I can't remember what the issue was with this option
vim.g.indentLine_char_list = { '▏', '¦', '┆', '┊' }
vim.g.indentLine_setColors = 0
vim.g.indentLine_setConceal = 0
-- Enable inline error messages
