-- Hotkey bindings.
local spaces = require("spaces")

-- Cmd + ` -> launch the terminal, or toggle to it / previous space
hs.hotkey.bind({ "cmd" }, "`", spaces.toggleTerminal)

-- Cmd + Shift + ` -> move focused window to the terminal's space and follow
hs.hotkey.bind({ "cmd", "shift" }, "`", spaces.moveFocusedToTerminal)

-- Option + Shift + N -> move focused window to desktop N and follow
for n = 1, 9 do
    hs.hotkey.bind({ "alt", "shift" }, tostring(n), function()
        spaces.moveFocusedToIndex(n)
    end)
end
