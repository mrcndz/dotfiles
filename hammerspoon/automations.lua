-- Background automations.

local haScript = os.getenv("HOME") .. "/.hammerspoon/ha-switch.sh"
local LOG = os.getenv("HOME") .. "/.config/ha/hammerspoon.log"

local function logEvent(msg)
    local f = io.open(LOG, "a")
    if f then f:write(os.date() .. " " .. msg .. "\n"); f:close() end
end

-- Toggle Home Assistant lights on display sleep/wake.
local w = hs.caffeinate.watcher
-- Held in a module table (returned below) so the watcher isn't garbage
-- collected after this file loads — a collected watcher silently stops firing.
local M = {}
M.haWatcher = w.new(function(event)
    logEvent("event id: " .. tostring(event))
    if event == w.screensDidSleep then
        logEvent("-> turn_off")
        hs.task.new("/bin/bash", nil, { haScript, "turn_off" }):start()
    elseif event == w.screensDidWake then
        logEvent("-> turn_on")
        hs.task.new("/bin/bash", nil, { haScript, "turn_on" }):start()
    end
end)
M.haWatcher:start()
logEvent("watcher started")

return M
