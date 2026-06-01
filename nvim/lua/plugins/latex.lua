return {
  {
    'lervag/vimtex',
    lazy = false,
    ft = { 'tex', 'plaintex', 'bib' },
    init = function()
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1

      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_mappings_prefix = '<localleader>'

      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        cites = 1,
        fancy = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 0,
        styles = 1,
      }
      vim.g.vimtex_syntax_conceal_disable = 0
      vim.opt.conceallevel = 2
    end,
  },
}
