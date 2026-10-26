-- Share one monitor between two Macs that also share keyboard/mouse via Universal Control.
-- Hotkey on either Mac pulls the monitor to it; the other Mac sees the input change over
-- DDC and disables its copy, so Universal Control stops showing the monitor twice.
local M = {}

local DISPLAYCTL = os.getenv("HOME") .. "/.local/bin/displayctl"
local M1DDC = "/opt/homebrew/bin/m1ddc"
local MONITOR = "DELL P2725QE"
local POLL_SECONDS = 3

-- DDC input codes: macpro is on USB-C (27), the other Mac on HDMI 1 (17).
local myInput = hs.host.localizedName() == "macpro" and 27 or 17

local function run(cmd, args, callback)
    hs.task.new(cmd, function(code, stdout)
        if callback then callback(code, stdout) end
    end, args):start()
end

local function monitorEnabled()
    for _, screen in ipairs(hs.screen.allScreens()) do
        if screen:name() == MONITOR then return true end
    end
    return false
end

-- Blocks the poll while taking, so it doesn't read the old input and disable us again.
local taking = false

-- DDC needs a moment after the monitor is re-enabled, so retry the input switch.
local function setInput(attempt)
    run(M1DDC, { "set", "input", tostring(myInput) }, function(code)
        if code ~= 0 and attempt < 10 then
            hs.timer.doAfter(0.5, function() setInput(attempt + 1) end)
        else
            hs.timer.doAfter(POLL_SECONDS, function() taking = false end)
        end
    end)
end

function M.take()
    taking = true
    if monitorEnabled() then
        setInput(1)
    else
        run(DISPLAYCTL, { "on" }, function() setInput(1) end)
    end
end

-- Disable our copy once the monitor shows another input. Read errors are ignored.
local function poll()
    if taking or not monitorEnabled() then return end
    run(M1DDC, { "get", "input" }, function(code, stdout)
        local current = tonumber(stdout)
        if code == 0 and current and current > 0 and current ~= myInput then
            run(DISPLAYCTL, { "off", MONITOR })
        end
    end)
end

-- Ctrl + Option + Cmd + M -> show this Mac on the shared monitor
M.hotkey = hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "M", M.take)
M.timer = hs.timer.doEvery(POLL_SECONDS, poll)

return M
