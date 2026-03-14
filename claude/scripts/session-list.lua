-- Reads ~/.claude/history.jsonl + active sessions, outputs fzf-ready lines
-- Usage: lua session-list.lua [active-sessions.json]

local G = "\27[32m"
local R = "\27[31m"
local D = "\27[2m"
local C = "\27[36m"
local X = "\27[0m"

-- Simple JSON string value extractor (no lib needed)
local function json_str(line, key)
  return line:match('"' .. key .. '":"([^"]*)"')
end

local function json_num(line, key)
  return tonumber(line:match('"' .. key .. '":(%d+)'))
end

-- Load active sessions
local active = {}
local active_file = arg[1] or os.getenv("HOME") .. "/.claude/.active-sessions.json"
local af = io.open(active_file, "r")
if af then
  local content = af:read("*a")
  af:close()
  -- Parse: {"sid": {"sess": "...", "pane": "..."}, ...}
  for sid, sess, pane in content:gmatch('"([^"]+)":%s*{%s*"sess":%s*"([^"]*)",%s*"pane":%s*"([^"]*)"') do
    active[sid] = { sess = sess, pane = pane }
  end
end

-- Read history.jsonl, keep last entry per sessionId
local sessions = {}
local order = {}
local histfile = os.getenv("HOME") .. "/.claude/history.jsonl"
local f = io.open(histfile, "r")
if not f then os.exit(0) end

for line in f:lines() do
  local sid = json_str(line, "sessionId")
  if sid then
    local ts = json_num(line, "timestamp")
    local project = json_str(line, "project") or ""
    local display = json_str(line, "display") or ""
    -- Clean display
    display = display:gsub("\\n", " "):gsub("\\t", " "):gsub("\\r", " "):sub(1, 120)

    if not sessions[sid] then
      order[#order + 1] = sid
    end
    sessions[sid] = { ts = ts, project = project, msg = display }
  end
end
f:close()

-- Sort by timestamp descending
table.sort(order, function(a, b)
  return (sessions[a].ts or 0) > (sessions[b].ts or 0)
end)

-- Output
for _, sid in ipairs(order) do
  local s = sessions[sid]
  local ts_sec = math.floor(s.ts / 1000)
  local dt = os.date("%m/%d %H:%M", ts_sec)

  -- Repo name
  local repo = s.project:match("([^/]+)$") or ""
  local wt_repo, wt_branch = s.project:match("(.+)/.claude/worktrees/(.*)")
  if wt_repo then
    repo = wt_repo:match("([^/]+)$") .. "/" .. wt_branch
  end

  local dot, rc, tmux_sess, tmux_pane
  if active[sid] then
    dot = G .. "●" .. X
    rc = G .. repo .. X
    tmux_sess = active[sid].sess
    tmux_pane = active[sid].pane
  else
    dot = R .. "●" .. X
    rc = C .. repo .. X
    tmux_sess = ""
    tmux_pane = ""
  end

  io.write(string.format("%s\t%s [%s%s%s] %s %s%s%s\t%s\t%s\t%s\n",
    sid, dot, D, dt, X, rc, D, s.msg, X, tmux_sess, tmux_pane, s.project))
end
