return {
  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.material_style = 'deep ocean'
      local hour = tonumber(os.date('%H'))
      -- if hour > 7 and hour < 17 then
      --   vim.g.material_style = 'lighter'
      -- end
    end,
    config = function()
      require('material').setup({
        disable = {
          background = false,
        },
        lualine_style = 'default',
      })
      vim.cmd('colorscheme material')

      local highlihts = {
        'BufferDefaultCurrent',
        'BufferDefaultCurrentADDED',
        'BufferDefaultCurrentBtn',
        'BufferDefaultCurrentCHANGED',
        'BufferDefaultCurrentDELETED',
        'BufferDefaultCurrentERROR',
        'BufferDefaultCurrentHINT',
        'BufferDefaultCurrentIcon',
        'BufferDefaultCurrentIndex',
        'BufferDefaultCurrentINFO',
        'BufferDefaultCurrentNumber',
        'BufferDefaultCurrentMod',
        'BufferDefaultCurrentModBtn',
        'BufferDefaultCurrentPin',
        'BufferDefaultCurrentPinBtn',
        'BufferDefaultCurrentSign',
        'BufferDefaultCurrentSignRight',
        'BufferDefaultCurrentTarget',
        'BufferDefaultCurrentWARN',
        'BufferCurrent',
        'BufferCurrentADDED',
        'BufferCurrentBtn',
        'BufferCurrentCHANGED',
        'BufferCurrentDELETED',
        'BufferCurrentERROR',
        'BufferCurrentHINT',
        'BufferCurrentIcon',
        'BufferCurrentIndex',
        'BufferCurrentINFO',
        'BufferCurrentNumber',
        'BufferCurrentMod',
        'BufferCurrentModBtn',
        'BufferCurrentPin',
        'BufferCurrentPinBtn',
        'BufferCurrentSign',
        'BufferCurrentSignRight',
        'BufferCurrentTarget',
        'BufferCurrentWARN',
      }

      for _, hl in ipairs(highlihts) do
        vim.cmd('hi ' .. hl .. ' guifg=gray')
      end
    end,
  },
}
