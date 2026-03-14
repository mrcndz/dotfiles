return {
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    init = function()
      vim.g.nvim_surround_no_mappings = true
    end,
    config = function()
      require('nvim-surround').setup {
        surrounds = {
          ['('] = { add = { '(', ')' } },
          ['['] = { add = { '[', ']' } },
          ['{'] = { add = { '{', '}' } },
          ['<'] = { add = { '<', '>' } },
        },
      }

      vim.keymap.set('n', 'sa', '<Plug>(nvim-surround-normal)')
      vim.keymap.set('n', 'saa', '<Plug>(nvim-surround-normal-cur)')
      vim.keymap.set('n', 'Sa', '<Plug>(nvim-surround-normal-line)')
      vim.keymap.set('n', 'Saa', '<Plug>(nvim-surround-normal-cur-line)')
      vim.keymap.set('x', 'sa', '<Plug>(nvim-surround-visual)')
      vim.keymap.set('x', 'Sa', '<Plug>(nvim-surround-visual-line)')
      vim.keymap.set('n', 'sd', '<Plug>(nvim-surround-delete)')
      vim.keymap.set('n', 'sr', '<Plug>(nvim-surround-change)')
      vim.keymap.set('n', 'Sr', '<Plug>(nvim-surround-change-line)')
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
}
