## Git rules
<git-rules>
- Never use git add .
- When asked to commit, always see staged files first
- Use `git flow` when needed
- Use convetional commit messages written in English, with a short title and short description.
- Never add Co-authored with Claude message to commits or pull requests.
- When asked to "open a PR for [branch]" (e.g., main, staging):
  1. Create a new branch from `origin/<target-branch>`
  2. Apply changes (commits, cherry-picks, etc.)
  3. Push and open the PR targeting `<target-branch>`
  4. If multiple targets are specified, repeat the full process independently for each one.
</git-rules>

<code-generation-rules>
- Make comments in english, always prefer short comments over long comments.
- Only comment on code that is not self-explanatory. The code must be clear enough to understand what it does.
- Always use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask.
</code-generation-rules>

<tolling-shell-interactions>
Install if missing.
- Is it about finding FILES? use 'fd'
- Is it about finding TEXT/strings? use 'rg'
- Is it about finding CODE STRUCTURE? use 'ast-grep'
- Is it about SELECTING from multiple results? pipe to 'fzf'
- Is it about interacting with JSON? use 'jq'
- Is it about interacting with YAML or XML? use 'yq'
- Always uses context7 mcp for seeking documentation, code generation, setup or configuration steps without me having to explicitly ask. If it's not available ask me for it.

⚠️ MANDATORY: Fish Shell for ALL Commands

> **CRITICAL RULE — READ BEFORE ANY COMMAND EXECUTION**

The Bash tool executes in zsh/bash. Your environment (fnm, pyenv, bun, etc.) exists ONLY in fish.

🐟 THE RULE: ALWAYS use `fish -c "command"`
**EVERY command. No exceptions. No thinking required.**

```bash
# Pattern
fish -c "your command here"

# Examples
fish -c "node -v"
fish -c "pnpm install"
fish -c "bun run dev"
fish -c "python --version"
fish -c "git status"
fish -c "ls -la"
```

Why this matters:
- `node`, `bun`, `pnpm` → Managed by `fnm` → Only in fish PATH
- `python`, `uv`, `pip` → Managed by `pyenv` → Only in fish PATH
- `ruby`, `gem`, `bundle` → Managed by `rbenv` → Only in fish PATH
- Environment variables → Set in `~/.config/fish/config.fish`

DO NOT:
❌ `node -v` → Will fail: "command not found"
❌ `pnpm install` → Will fail: "command not found"
❌ Run any command without `fish -c` wrapper

DO:
✅ `fish -c "node -v"`
✅ `fish -c "pnpm install"`
✅ `fish -c "ls -la"` (even simple commands - consistency matters)

</tolling-shell-interactions>

<notifications>
When you complete a big task, send a push notification:

```bash
~/.claude/hooks/notify.sh "Title" "Brief summary of what was done"
```

Do not send notifications for every command. Only for big tasks.
</notifications>

