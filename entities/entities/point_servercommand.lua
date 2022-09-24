ENT.Type = "point"

function ENT:AcceptInput(name, caller, activator, arg)
	name = string.lower(name)
	if name == "command" then
		if string.sub(string.lower(arg), 1, 4) == "say " then
			PrintMessage(HUD_PRINTTALK, string.sub(arg, 5))
		end

		return true
	end
end
