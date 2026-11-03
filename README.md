# dotfiles

Personal configuration, installed by `./install` (fish) from `install.yaml`: pre-commands, then
symlinks into `$HOME`, then post-commands. Each step prints `@ target -> source` on success or
`Error executing previous command` on failure.

## Tern (this `tern` branch)

The `tern` branch keeps the configuration that works with [Tern](https://docs.stencil.so/tern/):
`<C-h/j/k/l>` in Neovim crosses from a split edge into the neighbouring Tern, herdr or tmux pane
(`nvim/lua/config/cross-nav.lua`), and the Claude statusLine. The Tern plugin, its agent CLI,
the Claude Code hooks that report agent states and the agent skills are not part of the dotfiles:
install them from their own repository, after `./install`.

```fish
cd ~/Workspace/Repos/dotfiles
git fetch origin
git checkout tern
./install
```

`./install` is safe to re-run. It links `~/.claude/settings.json`, `CLAUDE.md` and
`statusline-command.sh` to `claude/`; an existing regular file is first moved to
`<file>.backup`, so compare it for machine-specific entries and copy back anything still needed.

