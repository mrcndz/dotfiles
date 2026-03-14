return {
  {
    'Bekaboo/dropbar.nvim',
    event = 'BufReadPost',
    config = function()
      require('dropbar').setup { enable = true }
    end,
  },
  {
    'nmac427/guess-indent.nvim',
    event = 'BufReadPost',
    config = function()
      require('guess-indent').setup {}
    end,
  },
  {
    'linrongbin16/lsp-progress.nvim',
    event = 'LspAttach',
    config = function()
      require('lsp-progress').setup {}
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'echasnovski/mini.icons', config = function() require('mini.icons').setup() end },
    },
    config = function()
      local function setup_lualine()
        local utils = require 'lualine.utils.utils'
        local extracted_bg = utils.extract_color_from_hllist('bg', { 'Normal' }, '')
        local bg = (extracted_bg ~= '' and extracted_bg ~= nil) and extracted_bg or nil
        local colors = {
          insert = utils.extract_color_from_hllist('fg', { 'MiniIconsGreen', 'String' }, '#98c379'),
          normal = utils.extract_color_from_hllist('fg', { 'MiniIconsGrey', 'Comment' }, '#808080'),
          replace = utils.extract_color_from_hllist('fg', { 'MiniIconsBlue', 'Function' }, '#61afef'),
          visual = utils.extract_color_from_hllist('fg', { 'MiniIconsRed', 'Error' }, '#e06c75'),
          command = utils.extract_color_from_hllist('fg', { 'MiniIconsBlue', 'Function' }, '#61afef'),
          icon = utils.extract_color_from_hllist('fg', { 'MiniIconsGreen', 'String' }, '#98c379'),
          git = utils.extract_color_from_hllist('fg', { 'MiniIconsRed', 'Error' }, '#e06c75'),
          line = utils.extract_color_from_hllist('fg', { 'MiniIconsRed', 'Error' }, '#e06c75'),
          lsp_progress = utils.extract_color_from_hllist('fg', { 'MiniIconsPurple', 'Statement' }, '#c678dd'),
        }

      local theme = {
        normal = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.normal },
          c = { bg = bg },
        },
        insert = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.insert },
          c = { bg = bg },
        },
        replace = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.replace },
          c = { bg = bg },
        },
        visual = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.visual },
          c = { bg = bg },
        },
        command = {
          a = { bg = bg },
          b = { bg = bg, fg = colors.command },
          c = { bg = bg },
        },
      }

      local nvim_icon = function()
        return ''
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          globalstatus = true,
          theme = theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'NvimTree' },
        },
        sections = {
          lualine_a = {
            { nvim_icon, color = { fg = colors.icon } },
          },
          lualine_b = {
            { 'mode' },
          },
          lualine_c = {
            {
              'filename',
              icon = { '', color = { fg = 'grey' } },
              filestatus = true,
              symbols = { modified = '', readonly = '', unnamed = '󰡯', newfile = '' },
              path = 1,
              color = { fg = colors.normal },
            },
            { 'filetype', icon_only = true, color = { bg = bg }, padding = { left = 1, right = 1 } },
            { 'branch', icon = '', color = { fg = colors.git } },
            {
              function()
                local reg = vim.fn.reg_recording()
                return reg ~= '' and 'REC @' .. reg or ''
              end,
              color = { fg = '#ff0000' },
            },
          },
          lualine_x = {
            { 'diagnostics', color = { bg = bg } },
            {
              function()
                return require('lsp-progress').progress()
              end,
              color = { fg = 'gray' },
            },
          },
          lualine_y = {},
          lualine_z = { { 'location', icon = { '', align = 'right' }, color = { fg = colors.line } } },
        },
        inactive_sections = {
          lualine_a = {
            { nvim_icon, color = { fg = colors.icon } },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }

        -- NVIM 0.11
        vim.api.nvim_set_hl(0, 'StatusLine', { reverse = false })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { reverse = false })
      end

      vim.schedule(setup_lualine)

      -- Refresh lualine on colorscheme change or session restore
      vim.api.nvim_create_autocmd({ 'ColorScheme', 'SessionLoadPost', 'VimEnter' }, {
        pattern = '*',
        callback = function()
          setup_lualine()
        end,
      })

      vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        group = 'lualine_augroup',
        pattern = 'LspProgressStatusUpdated',
        callback = function()
          require('lualine').refresh {}
        end,
      })
    end,
  },
  -- Dark theme
  {
    'akinsho/horizon.nvim',
    version = '*',
    lazy = false,
    priority = 1000,
  },
  -- Light theme
  {
    'yorik1984/newpaper.nvim',
    lazy = false,
    priority = 1000,
  },
  -- Auto theme switcher based on macOS appearance
  {
    'f-person/auto-dark-mode.nvim',
    lazy = false,
    priority = 999,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
        vim.cmd.colorscheme 'horizon'
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', {})
        vim.cmd.colorscheme 'newpaper'
      end,
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    config = function()
      require('gitsigns').setup {}
    end,
  },
}
