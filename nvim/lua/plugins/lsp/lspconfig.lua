return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      { 'williamboman/mason.nvim', opts = true },
      { 'williamboman/mason-lspconfig.nvim', opts = true },
    },
    opts = {
      ensure_installed = {
        -- Lua
        'lua_ls',
        'stylua',
        -- Python
        'pyright',
        'ruff',
        'debugpy',
        'black',
        'isort',
        'taplo',
        -- Rust
        'rust_analyzer',
        -- Markdown
        'marksman',
        -- Json
        'jsonls',
        -- Yaml
        'yamlls',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Setup diagnostics
      local signs = { Error = '󱔷', Warn = '󰾕', Hint = '', Info = '󰾚' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end

      local lspconfig = require 'lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(client, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        local opts = { noremap = true, silent = true }

        vim.api.nvim_create_user_command('LspAddWorkspace', function(args)
          vim.lsp.buf.add_workspace_folder(args.args)
        end, {
          nargs = 1,
          complete = 'dir',
          desc = 'add a workspace folder',
        })
      end

      lspconfig['pyright'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'workspace',
            },
          },
        },
      }

      lspconfig['ruff'].setup {
        settings = {
          organizeImports = false,
        },
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      }

      local servers = {
        'lua_ls',
        'jsonls',
        'marksman',
        'yamlls',
        'jsonls',
        'rust_analyzer',
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup {
          capabilities = capabilities,
          on_attach = on_attach,
        }
      end

      -- Diagnostics
      vim.diagnostic.config {
        underline = false,
        virtual_text = {
          severity = vim.diagnostic.severity.ERROR,
          spacing = 4,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󱔷',
            [vim.diagnostic.severity.WARN] = '󰾕',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '󰾚',
          },
          line_hl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          },
        },
        float = {
          border = 'rounded',
          source = true,
        },
      }
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        'luvit-meta/library',
        'LazyVim',
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },

      enabled = function(root_dir)
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
    },
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<F2>',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        fish = { 'fish_indent' },
        rust = { 'rustfmt' },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2' },
        },
      },
    },

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
      bind = true,
      handler_opts = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      local cfg = {
        floating_window_off_x = 5, -- adjust float windows x position.
        floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
          local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
          local pumheight = vim.o.pumheight
          local winline = vim.fn.winline() -- line number in the window
          local winheight = vim.fn.winheight(0)

          -- window top
          if winline - 1 < pumheight then
            return pumheight
          end

          -- window bottom
          if winheight - winline < pumheight then
            return -pumheight
          end
          return 0
        end,
      }
      require('lsp_signature').setup(cfg)
    end,
  },
}
