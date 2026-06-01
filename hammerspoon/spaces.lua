local M = {}

local SWITCH_MOD = "alt"

-- The terminal app to manage. Change these two to use a different terminal.
local TERMINAL_BUNDLE = "com.mitchellh.ghostty"
local TERMINAL_NAME = "Ghostty"

-- User spaces (type "user", i.e. not fullscreen) on a screen, in order.
function M.userSpaces(screen)
    local ids = hs.spaces.spacesForScreen(screen) or {}
    local user = {}
    for _, id in ipairs(ids) do
        if hs.spaces.spaceType(id) == "user" then
            user[#user + 1] = id
        end
    end
    return user
end

-- 1-based index of a space id within its own screen's user spaces.
local function indexOfSpace(spaceId)
    for _, scr in ipairs(hs.screen.allScreens()) do
        local user = M.userSpaces(scr)
        for i, id in ipairs(user) do
            if id == spaceId then return i end
        end
    end
    return nil
end

local function goToSpace(spaceId)
    local idx = indexOfSpace(spaceId)
    if idx then
        hs.eventtap.keyStroke({ SWITCH_MOD }, tostring(idx), 0)
    else
        hs.spaces.gotoSpace(spaceId) -- fallback if the space was reordered/removed
    end
end

local function terminalWindow()
    local app = hs.application.get(TERMINAL_BUNDLE) or hs.application.get(TERMINAL_NAME)
    if not app then return nil end
    return app:mainWindow() or app:allWindows()[1]
end

local function terminalSpace()
    local win = terminalWindow()
    if not win then return nil end
    local s = hs.spaces.windowSpaces(win)
    return s and s[1] or nil
end

-- Drag a window to another desktop and follow it. moveWindowToSpace is a no-op
-- on recent macOS, so we press-and-hold the window's top edge, switch desktop,
-- then release: macOS carries a "grabbed" window along. `switch` performs the
-- desktop change while the window is held.
local function dragWindow(win, switch)
    -- Grab the titlebar just right of the traffic-light buttons: always
    -- draggable chrome, and left of center so it avoids inputs like Safari's
    -- centered address bar.
    local f = win:frame()
    local grab = hs.geometry.point(f.x + math.min(90, f.w / 2), f.y + 12)
    local origin = hs.mouse.absolutePosition()

    win:focus()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, grab):post()
    hs.timer.usleep(40000)
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDragged,
        hs.geometry.point(grab.x + 1, grab.y + 1)):post()
    hs.timer.usleep(40000)

    switch()

    hs.timer.doAfter(0.45, function()
        hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, grab):post()
        win:focus()
        -- Restore the cursor after the release is processed, so it ends up back
        -- where it started instead of at the drop point.
        hs.timer.doAfter(0.05, function()
            hs.mouse.absolutePosition(origin)
        end)
    end)
end

-- The space to return to when toggling off the terminal. Focusing a window
-- natively switches to its space (fast, no animation) — the whole trick.
local prevSpace = nil

-- Cmd+` :
--  1. Terminal quit       -> launch it.
--  2. Focused on terminal -> go back to the previous space.
--  3. Otherwise           -> save current space, focus terminal (jumps to it).
function M.toggleTerminal()
    local win = terminalWindow()
    if not win then
        hs.application.launchOrFocus(TERMINAL_NAME)
        return
    end

    local focused = hs.window.focusedWindow()
    local fapp = focused and focused:application()
    if fapp and fapp:bundleID() == TERMINAL_BUNDLE then
        if prevSpace then
            goToSpace(prevSpace)
            prevSpace = nil
        end
    else
        prevSpace = hs.spaces.focusedSpace()
        win:focus()
    end
end

function M.moveFocusedToTerminal()
    local tspace = terminalSpace()
    if not tspace then return end
    local win = hs.window.focusedWindow()
    if not win or win == terminalWindow() then return end
    prevSpace = hs.spaces.focusedSpace() -- so Cmd+` bounces back here
    dragWindow(win, function() goToSpace(tspace) end)
end

-- Move the focused window to desktop N (native Option+N) and follow it.
function M.moveFocusedToIndex(n)
    local win = hs.window.focusedWindow()
    if not win then return end
    dragWindow(win, function()
        hs.eventtap.keyStroke({ SWITCH_MOD }, tostring(n), 0)
    end)
end

return M
