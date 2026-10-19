# dotfiles

Personal configuration, installed by `./install` (fish) from `install.yaml`: pre-commands, then
symlinks into `$HOME`, then post-commands. Each step prints `@ target -> source` on success or
`Error executing previous command` on failure.

## Tern setup (this `tern` branch)

The `tern` branch adds [Tern](https://docs.stencil.so/tern/) on top of `main`: the
[tern-kit](https://github.com/mrcndz/tern-kit) plugin (vi-style prefix keys, popups, agent
states and Claude's quota in the status bar), its `tern-kit` CLI and `tern` skill, and the Claude
Code hooks that report agent states. These steps are written so an agent can follow them.

### Requirements

- macOS with Tern installed (`/Applications/Tern.app`), and `tern` on `PATH`.
- `fish`, `yq`, `git`, `python3` and `jq`.
- An SSH key with access to the private `git@github.com:mrcndz/tern-kit.git`. Check with
  `ssh -T git@github.com`.

### Install

```fish
cd ~/Workspace/Repos/dotfiles
git fetch origin
git checkout tern
./install
```

`./install` is safe to re-run. What it does for Tern:

- Clones tern-kit into `~/Workspace/Repos/tern-kit`; if that folder already exists, the clone
  fails harmlessly. Update it with `git -C ~/Workspace/Repos/tern-kit pull`.
- Links `~/.config/tern-kit/settings.json` to `tern/settings.json`, the Tern preferences
  tern-kit enforces (keymap `tmux`, prefix `ctrl+a`, keybinds, themes).
- Links `~/.local/bin/tern-kit` and `~/.agents/skills/tern` from tern-kit.
- Runs `tern plugin link ~/Workspace/Repos/tern-kit`.
- Links `~/.claude/settings.json`, `CLAUDE.md` and `statusline-command.sh` to `claude/`. An
  existing regular file is first moved to `<file>.backup`; compare the backup for
  machine-specific entries (hook paths under another home folder) and copy back anything still
  needed.

Every link's parent folder is created first, so this works on a fresh machine.

### Finish

1. Quit and reopen Tern, so its window loads the plugin and applies `tern/settings.json`.
2. Restart running Claude Code sessions, so they load the hooks.
3. Restart Neovim, so `<C-h/j/k/l>` loads tern-kit's navigation.
4. Link the skill for Claude Code too, if `~/.claude/skills` holds links into `~/.agents/skills`:
   `ln -sfn ../../.agents/skills/tern ~/.claude/skills/tern`.

### Verify

Run these from a shell inside a Tern pane (`$TERN_PANE` set), not inside Herdr or tmux:

```fish
tern plugin list                                    # kit 0.1.0 Tern kit … ready
readlink ~/.config/tern-kit/settings.json           # …/dotfiles/tern/settings.json
tern-kit --help                                     # usage: tern-kit [-h] {hook,statusline,nav,agent} ...
grep -c tern-kit ~/.claude/settings.json            # 8 (one hook per event)
python3 -c 'import json,os; d=json.load(open(os.path.expanduser("~/Library/Application Support/Tern/settings.json"))); print(d["keymap"], d["keymap_prefix"])'
                                                    # tmux ctrl+a (after reopening Tern)
```

End to end, start an agent and check its state:

```fish
set pane (tern-kit agent start --tab -- claude | python3 -c 'import json,sys; print(json.load(sys.stdin)["pane"])')
tern-kit agent wait $pane --until ready --timeout 60000   # "state": "idle", from the SessionStart hook
tern-kit agent prompt $pane "Reply with exactly OK" --wait --timeout 120000   # "state": "done"
tern close $pane
```

If `agent wait` times out, the hooks are not loaded: check `grep -c tern-kit ~/.claude/settings.json`
and that the Claude session started after the install.

### Notes

- Tern replaces its own `settings.json` when it saves, so it is not symlinked; change Tern
  preferences in `tern/settings.json` and tern-kit applies them at each window start.
- `TERN_PANE` inherited through Herdr or tmux names the outer Tern pane, so tern-kit ignores it
  there; agents only report states when they run directly in a Tern pane.
- Keys, commands and the agent CLI are documented in tern-kit's README.
