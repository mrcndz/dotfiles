-- Share one monitor between two Macs that also share keyboard/mouse via Universal Control.
-- The Mac not on screen disables its copy, so Universal Control stops showing the monitor twice.
local M = {}

local DISPLAYCTL = os.getenv("HOME") .. "/.local/bin/displayctl"
local M1DDC = "/opt/homebrew/bin/m1ddc"
local MONITOR = "DELL P2725QE"
local POLL_SECONDS = 3

-- DDC input codes: macpro is on USB-C (27), the other Mac on HDMI 1 (17).
-- Only macpro polls: DDC reads through the other Mac's HDMI adapter return garbage.
local IS_MACPRO = hs.host.localizedName() == "macpro"
local myInput = IS_MACPRO and 27 or 17
local otherInput = IS_MACPRO and 17 or 27

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

-- Writes through the HDMI adapter can be dropped while still exiting 0, so send it a few times.
local function setInput(attempt)
    run(M1DDC, { "set", "input", tostring(myInput) }, function()
        if attempt < 3 then
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
        -- DDC needs a moment after the monitor is re-enabled.
        run(DISPLAYCTL, { "on" }, function()
            hs.timer.doAfter(2, function() setInput(1) end)
        end)
    end
end

-- Hand the monitor to the other Mac and disable our copy.
function M.give()
    run(M1DDC, { "set", "input", tostring(otherInput) }, function()
        run(DISPLAYCTL, { "off", MONITOR })
    end)
end

function M.toggle()
    if monitorEnabled() then M.give() else M.take() end
end

-- Follow the input: disable our copy when it shows the other Mac, re-enable when it's back.
-- Unknown values are ignored. macpro reads DDC even while its copy is disabled.
local function poll()
    if taking then return end
    run(M1DDC, { "get", "input" }, function(code, stdout)
        local current = tonumber(stdout)
        if code ~= 0 then return end
        if current == otherInput and monitorEnabled() then
            run(DISPLAYCTL, { "off", MONITOR })
        elseif current == myInput and not monitorEnabled() then
            run(DISPLAYCTL, { "on" })
        end
    end)
end

-- Ctrl + Option + Cmd + M -> macpro: show macpro; other Mac: toggle between both Macs
M.hotkey = hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "M", IS_MACPRO and M.take or M.toggle)
if IS_MACPRO then
    M.timer = hs.timer.doEvery(POLL_SECONDS, poll)
end

return M
