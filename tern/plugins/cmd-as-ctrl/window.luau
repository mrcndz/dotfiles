-- Same keys as the Ghostty config: Ctrl keys stay untouched
local function send(bytes)
	return function(cx)
		local pane = cx.session:focused()
		if pane then
			cx:run(pane, bytes)
		end
	end
end

for c = string.byte("a"), string.byte("z") do
	local key = string.char(c)
	-- keep Cmd+Q (quit) and Cmd+V (paste)
	if key ~= "q" and key ~= "v" then
		tern.bind("cmd+" .. key, send(string.char(c - 96)))
	end
end

-- herdr prefix (Ctrl+A) and the digit
for d = 1, 9 do
	tern.bind("cmd+" .. d, send("\x01" .. d))
end
