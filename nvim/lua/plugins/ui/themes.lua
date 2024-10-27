local mode = 'dark' -- dark or light

return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    require('gruvbox').setup({
      contrast = 'soft',
    })
    vim.cmd('colorscheme gruvbox')

    if os.getenv('THEME') == 'light' then
      vim.cmd('set background=light')
    else
      vim.cmd('set background=dark')
    end
  end,
}
