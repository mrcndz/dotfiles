return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  config = function()
    default_args = {
      DiffviewOpen = { "--untracked-files=no", "--imply-local" },
      DiffviewFileHistory = { "--base=LOCAL" },
    }
  end,
}
