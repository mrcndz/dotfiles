return {
  'robitx/gp.nvim',
  dependencies = {
    'folke/which-key.nvim',
  },
  config = function()
    require('gp').setup()
    local wk = require('which-key')

    wk.add({
      {
        mode = 'v',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
        { '<leader>G', group = 'Gp' },
        { '<leader>Gc', group = 'Chat' },
        { '<leader>Gcn', ":<C-u>'<,'>GpChatNew<cr>", desc = 'Visual Chat New' },
        { '<leader>Gcp', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
        { '<leader>Gct', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },
        -- { '<leader>Gc-', ":<C-u>'<,'>GpChatNew split<cr>", desc='Visual Chat New split' },
        -- { '<leader>Gc|', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc='Visual Chat New vsplit' },
        -- { '<leader>Gct', ":<C-u>'<,'>GpChatNew tabnew<cr>", desc='Visual Chat New tabnew' },

        { '<leader>Gr', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
        { '<leader>Ga', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
        { '<leader>Gi', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Visual Prepend (before)' },
        { '<leader>Gs', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },

        { '<leader>Gg', group = 'Generate' },
        { '<leader>Ggp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
        { '<leader>Gge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
        { '<leader>Ggn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
        { '<leader>Ggv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
        { '<leader>Ggt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },

        { '<leader>G>', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
        { '<leader>G.', '<cmd>GpStop<cr>', desc = 'GpStop' },
        { '<leader>G?', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual GpContext' },

        { '<leader>Gw', group = 'Whisper' },
        { '<leader>Gww', ":<C-u>'<,'>GpWhisper<cr>", desc = 'Whisper' },
        { '<leader>Gwr', ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = 'Whisper Rewrite' },
        { '<leader>Gwa', ":<C-u>'<,'>GpWhisperAppend<cr>", desc = 'Whisper Append (after)' },
        { '<leader>Gwb', ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = 'Whisper Prepend (before)' },
        { '<leader>Gwp', ":<C-u>'<,'>GpWhisperPopup<cr>", desc = 'Whisper Popup' },
        { '<leader>Gwe', ":<C-u>'<,'>GpWhisperEnew<cr>", desc = 'Whisper Enew' },
        { '<leader>Gwn', ":<C-u>'<,'>GpWhisperNew<cr>", desc = 'Whisper New' },
        { '<leader>Gwv', ":<C-u>'<,'>GpWhisperVnew<cr>", desc = 'Whisper Vnew' },
        { '<leader>Gwt', ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = 'Whisper Tabnew' },
      },
      {
        mode = 'n',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
        { '<leader>G', group = 'GPT' },

        { '<leader>Gc', group = 'Chat' },
        { '<leader>Gcn', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
        { '<leader>Gct', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
        { '<leader>Gcf', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
        -- { '<leader>Gc-', ":<C-u>'<,'>GpChatNew split<cr>", desc='New Chat split' },
        -- { '<leader>Gc|', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc='New Chat vsplit' },
        -- { '<leader>Gr', ":<C-u>'<,'>GpRewrite<cr>", desc='Inline Rewrite' },
        { '<leader>Gr', 'GpRewrite<cr>', desc = 'Inline Rewrite' },
        { '<leader>Ga', 'GpAppend<cr>', desc = 'Append (after)' },
        { '<leader>Gi', 'GpPrepend<cr>', desc = 'Prepend (before)' },

        { '<leader>Gg', group = 'Generate' },
        { '<leader>Ggp', 'GpPopup<cr>', desc = 'Popup' },
        { '<leader>Gge', 'GpEnew<cr>', desc = 'GpEnew' },
        { '<leader>Ggn', 'GpNew<cr>', desc = 'GpNew' },
        { '<leader>Ggv', 'GpVnew<cr>', desc = 'GpVnew' },
        { '<leader>Ggt', 'GpTabnew<cr>', desc = 'GpTabnew' },

        { '<leader>G>', 'GpNextAgent<cr>', desc = 'Next Agent' },
        { '<leader>G.', 'GpStop<cr>', desc = 'GpStop' },
        { '<leader>G?', 'GpContext<cr>', desc = 'Toggle GpContext' },

        { '<leader>Gw', group = 'Whisper' },
        { '<leader>Gww', 'GpWhisper<cr>', desc = 'Whisper' },
        { '<leader>Gwr', 'GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
        { '<leader>Gwa', 'GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
        { '<leader>Gwb', 'GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
        { '<leader>Gwp', 'GpWhisperPopup<cr>', desc = 'Whisper Popup' },
        { '<leader>Gwe', 'GpWhisperEnew<cr>', desc = 'Whisper Enew' },
        { '<leader>Gwn', 'GpWhisperNew<cr>', desc = 'Whisper New' },
        { '<leader>Gwv', 'GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
        { '<leader>Gwt', 'GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
      },
    })
  end,
}
