function redstoneloader()
	redstone = component.proxy(component.list("redstone")())
end
function inventoryloader()
	inventory = component.proxy(component.list("inventory_controller")())
end
function experienceloader()
	experience = component.proxy(component.list("experience")())
end
function chunkloaderloader()
	chunkloader = component.proxy(component.list("chunkloader")())
end
function chatloader()
	chat = component.proxy(component.list("chat",true)())
end
function robotloader()
	robot = component.proxy(component.list("robot")())
end
function internetloader()
	internet = component.proxy(component.list("internet")())
end
function getandsetname()
	if robot == nil then
		name = "generic"
	else
		name = robot.name()
	end
	chat.setName(name)
end
function loop()
	controluser = ""
	out = ""
	
	while true do
		local _, _, user, command = computer.pullSignal("chat_message")
		if command == "!help" then
			chat.say("§2!robot §4[control, release, override, reset] §2" .. name)
		end
		if command == "!robot reset" then
			if user == "Myros27" then
				controluser = ""
			end
		end
		if controluser == "" then
			if command == ("!robot control " .. name) then
				controluser = user
				chat.say("§2" .. controluser .. " took control over " .. name)
				while controluser ~= "" do
					value = "No return value"
					local _, _, user, command = computer.pullSignal("chat_message")
					if command == "!robot reset" then
						if user == "Myros27" then
							controluser = ""
						end
					end
					if command == ("!robot override " .. name) then
						if user == "Myros27" then
							controluser = "Myros27"
							chat.say("§2" .. controluser .. " took control over " .. name)
						end
					end
					if command == ("!robot release " .. name) then
						if user == controluser then
							controluser = ""
							chat.say("§2 released")
						end
					else
						if user == controluser then
							local func, err = load(command)
							if func then
								local ok, value = pcall(func)
								if out ~= "" then
									if type(out) == "string" then
										chat.say(out)
										out = ""
									end
									if type(out) == "nil" then
										chat.say("out is nil")
										out = ""
									end
									if type(out) == "number" then
										out = tostring(out)
										chat.say(out)
										out = ""
									end
									if type(out) == "boolean" then
										out = tostring(out)
										chat.say(out)
										out = ""
									end
									if type(out) == "table" then
										for key,wert in pairs(out) do
											chat.say(key,wert)
										end
										out = ""
									end
									if type(out) == "function" then
										out = tostring(out)
										chat.say(out)
										out = ""
									end
									if type(out) == "userdata" then
										out = tostring(out)
										chat.say(out)
										out = ""
									end
									if type(out) == "thread" then
										out = tostring(out)
										chat.say(out)
										out = ""
									end
								end
								if ok then
									chat.say("§2executed successfully")
								else
									value = tostring(value)
									chat.say("§2Execution error:§7 " .. value)
								end
							else
								err = tostring(err)
								chat.say("§4Compilation error:§7 " .. err)
							end	
						end
					end
				end
			end
		end
	end
end

name = "generic"
pcall(redstoneloader)
pcall(inventoryloader)
pcall(experienceloader)
pcall(chunkloaderloader)
pcall(chatloader)
pcall(robotloader)
pcall(getandsetname)
pcall(internetloader)
while true do
	pcall(loop())
	chat.say("§2FATAL ERROR, RESET!")
end
