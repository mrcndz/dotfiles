vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},

  focus_on_close = 'left',
  hide = {extensions = false, inactive = true},
  highlight_alternate = false,
  highlight_inactive_file_icons = false,
  highlight_visible = false,

  icons = {
    buffer_index = true,
    buffer_number = false,
    button = '',
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ''},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true, icon = ''},
    },
    filetype = {
      custom_colors = false,
      enabled = true,
    },
    separator_at_end = true,
    modified = {button = '●'},
    pinned = {button = '車', filename = true},

    preset = 'default',

    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },

  sidebar_filetypes = {
    NvimTree = true,
  },
}
