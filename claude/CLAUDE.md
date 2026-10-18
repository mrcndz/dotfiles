<git-rules>
- Never use git add .
- When asked to commit, always see staged files first
- Use convetional commit messages written in English, with a short title and short description.
- Never add Co-authored with Claude message to commits or pull requests.
- When asked to "open a PR for [branch]" (e.g., main, staging):
  1. Create a new branch from `origin/<target-branch>`
  2. Apply changes (commits, cherry-picks, etc.)
  3. Push and open the PR targeting `<target-branch>`
  4. If multiple targets are specified, repeat the full process independently for each one.
</git-rules>

<code-generation-rules>
- Only comment on code that is not self-explanatory. The code must be clear enough to understand what it does. Avoid long comments.
- Make comments in english, always prefer short comments over long comments.
- Always use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask.
- Always check and analyze codebase code standards and conventions before writing code.
- Always prefer code reuse over code duplication.
</code-generation-rules>

<tolling-shell-interactions>
- fish is the login shell so terminals start fish directly; use `fish -c "command"` when necessary like when using fish syntax or a command unexpectedly reports "command not found".
- Always uses context7 mcp for seeking documentation, code generation, setup or configuration steps without having to explicitly ask the user. 
- `drop <file>`: stages a file on the Dropover shelf for drag-and-drop (e.g. into an email or chat). Use when the user wants to drag a file somewhere or asks to "drop" it.
- You're always inside a herdr or tmux pane. The public Herdr pane ID format is wX:pY. When mentioned, use their CLI accordingly.
- Always use `ego` as you browser instead o f `chrome`. If ego-browser skill is not available, install it using `skills` command.
</tolling-shell-interactions>

<behavioral-guidelines>
# 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Language

1. Unless requested to use another language, always use English.
2. Strict formatting rule: Under no circumstances are you to use the "em-dash" (—) or "en-dash" (–) for dialogues, sentence breaks, or any other purpose. Instead of dashes, exclusively use commas (,), parentheses (), colons (:), semicolons (;), or quotation marks (" ") to structure the text.

</behavioral-guidelines>

@RTK.md
