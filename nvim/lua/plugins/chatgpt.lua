return {
  'robitx/gp.nvim',
  dependencies = {
    'folke/which-key.nvim',
  },
  config = function()
    local gp = require('gp')
    local wk = require('which-key')
    local wkicon = require('which-key.icons')

    gp.setup({
      hooks = {
        Explain = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by explaining the code above."
          local agent = gp.get_chat_agent()
          gp.Prompt(params, gp.Target.popup, agent, template)
        end,
      },
    })

    wk.add({
      {
        mode = 'v',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
        icon = wkicon.get({ pattern = 'ai', icon = ' ', color = 'green' }),
        { '<leader>a', group = 'AI' },
        { '<leader>ag', group = 'Generate' },

        { '<leader>ae', ":<C-u>'<,'>GpExplain<cr>", desc = 'Explain Code', icon = '󰛨' },

        { '<leader>agp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Popup', icon = { '󰙕' } },
        { '<leader>age', ":<C-u>'<,'>GpEnew<cr>", desc = 'New Buffer', icon = '󰛨' },
        { '<leader>ag-', ":<C-u>'<,'>GpNew<cr>", desc = 'Horizontal split', icon = '-' },
        { '<leader>ag|', ":<C-u>'<,'>GpVnew<cr>", desc = 'Vertical split', icon = '|' },
        -- { '<leader>agt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },

        { '<leader>ac', group = 'Chat' },
        { '<leader>acn', ":<C-u>'<,'>GpChatNew popup<cr>", desc = 'Visual Chat New', icon = '' },
        { '<leader>acp', ":<C-u>'<,'>GpChatPaste popup<cr>", desc = 'Visual Chat Paste', icon = '' },
        { '<leader>act', ":<C-u>'<,'>GpChatToggle popup<cr>", desc = 'Visual Toggle Chat', icon = '' },

        { '<leader>ar', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Rewrite', icon = '' },
        { '<leader>aa', ":<C-u>'<,'>GpAppend<cr>", desc = 'Append (after)', icon = '' },
        { '<leader>ai', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Prepend (before)', icon = '' },
        { '<leader>as', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection', icon = '' },

        { '<leader>aC', ":<C-u>'<,'>GpContext popup<cr>", desc = 'Add to Context', icon = '' },
        { '<leader>an', '<cmd>GpNextAgent<cr>', desc = 'Next Agent', icon = '' },
        { '<leader>ax', '<cmd>GpStop<cr>', desc = 'Stop', icon = '' },
      },
      {
        mode = 'n',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
        icon = wkicon.get({ pattern = 'ai', icon = ' ', color = 'green' }),
        { '<leader>a', group = 'AI', icon = 'ﮧ' },

        { '<leader>ag', group = 'Generate', icon = '' },
        { '<leader>agp', '<cmd>GpPopup<cr>', desc = 'Popup', icon = '󰙕' },
        { '<leader>age', '<cmd>GpEnew<cr>', desc = 'New buffer', icon = '󰛨' },
        { '<leader>ag-', '<cmd>GpNew<cr>', desc = 'Horizontal split', icon = '-' },
        { '<leader>ag|', '<cmd>GpVnew<cr>', desc = 'Vertical split', icon = '|' },
        -- { '<leader>agt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew', icon = '' },

        { '<leader>ac', group = 'Chat', icon = '' },
        { '<leader>acn', '<cmd>GpChatNew popup<cr>', desc = 'New Chat', icon = '' },
        { '<leader>act', '<cmd>GpChatToggle popup<cr>', desc = 'Toggle Chat', icon = '' },
        { '<leader>acf', '<cmd>GpChatFinder popup<cr>', desc = 'Chat Finder', icon = '' },
        -- { '<leader>ac-', ":<C-u>'<,'>GpChatNew split<cr>", desc='New Chat split', icon = '' },
        -- { '<leader>ac|', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc='New Chat vsplit', icon = '' },

        { '<leader>ar', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite', icon = '' },
        { '<leader>aa', '<cmd>GpAppend<cr>', desc = 'Append (after)', icon = '' },
        { '<leader>ai', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)', icon = '' },

        -- { '<leader>aw', group = 'Whisper', icon = '' },
        -- { '<leader>aww', '<cmd>GpWhisper<cr>', desc = 'Whisper', icon = '' },
        -- { '<leader>awr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite', icon = '﯑' },
        -- { '<leader>awa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)', icon = '' },
        -- { '<leader>awb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)', icon = '' },
        -- { '<leader>awp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup', icon = '' },
        -- { '<leader>awe', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew', icon = '' },
        -- { '<leader>awn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New', icon = '' },
        -- { '<leader>awv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew', icon = '' },
        -- { '<leader>awt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew', icon = '' },

        { '<leader>aC', '<cmd>GpContext popup<cr>', desc = 'Toggle Context', icon = '' },
        { '<leader>an', '<cmd>GpNextAgent<cr>', desc = 'Next Agent', icon = '' },
        { '<leader>ax', '<cmd>GpStop<cr>', desc = 'Stop', icon = '' },
      },
    })
  end,
}
