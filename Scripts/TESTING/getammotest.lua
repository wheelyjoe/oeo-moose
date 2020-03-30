-- GetAmmo Test --

AmmoTestFunction = {}
AmmoTestF10 = {}

function AmmoTestFunction(target)
	local AmmoTable = target:getAmmo()
	env.info("F10 menu option requested, got target's ammo.")
	trigger.action.outTextForGroup(target:getGroup():getID(), "You checked your loadout!", 20, 1)
	env.info("Sent message!")
end

function AmmoTestF10:onEvent(event)
	if event.id == 15 and event.initiator and event.initiator:getPlayerName() ~= nil
		then
			missionCommands.addCommandForGroup(event.initiator:getGroup():getID(), "Validate Loadout", nil, AmmoTestFunction, event.initiator)
			env.info("Found a spawn, adding F10 Menu to group.")
	end
end

world.addEventHandler(AmmoTestFunction)
world.addEventHandler(AmmoTestF10)