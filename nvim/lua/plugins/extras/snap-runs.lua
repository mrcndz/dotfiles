M = {}

M.run = function(snap, run_name)
  local fzf_file = {
    producer = snap.get('consumer.fzf')(snap.get('producer.ripgrep.file')),
    select = snap.get('select.file').select,
    multiselect = snap.get('select.file').multiselect,
    views = { snap.get('preview.file') },
  }

  local live_grep = {
    producer = snap.get('consumer.limit')(10000, snap.get('producer.ripgrep.vimgrep')),
    select = snap.get('select.vimgrep').select,
    multiselect = snap.get('select.vimgrep').multiselect,
    views = { snap.get('preview.vimgrep') },
  }

  local old_files = {
    producer = snap.get('consumer.fzy')(snap.get('producer.vim.oldfile')),
    select = snap.get('select.file').select,
    multiselect = snap.get('select.file').multiselect,
    views = { snap.get('preview.file') },
  }

  if run_name == 'fzf_file' then
    snap.run(fzf_file)
  end

  if run_name == 'live_grep' then
    snap.run(live_grep)
  end

  if run_name == 'old_files' then
    snap.run(old_files)
  end
end

return M
