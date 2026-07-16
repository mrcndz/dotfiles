#!/usr/bin/env bash
# SessionStart hook: tells Claude which multiplexer owns this pane.

if [ -n "$HERDR_ENV" ]; then
  context="This session runs inside a Herdr pane (HERDR_ENV=1). For any pane/tab/workspace or agent-to-agent work, use 'herdr' resources."
elif [ -n "$TMUX" ]; then
  context="This session runs inside a tmux pane (\$TMUX is set). For any pane/window work, use tmux resources."
else
  context="This session runs in a plain terminal, no multiplexer."
fi

jq -nc --arg c "$context" \
  '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $c}}'
