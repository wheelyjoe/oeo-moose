-- OEO Welcome Message Script --

WelcomeMessage = {}

function WelcomeMessage:onEvent(event)
	if
		event.id == 15 and event.initiator and event.initiator:getPlayerName() ~= nil
			then
				env.info("Found Spawn, sending welcome message")
				trigger.action.outTextForGroup(event.initiator:getGroup():getID(), "Welcome to Operation Enduring Odyssey!\n\n*** IMPORTANT INFORMATION *** \n\n1 - You MUST use the F10 Menu *Mission* to be assigned an objective! It will have the target's location and type!\n\n2 - There are limitations on Airframe Loadouts on OEO to discourage *SPAMRAAM* and *JSOW-TRUCK* style flying! Remember to check the briefing images for information, and use the F10 Menu *Validate Loadout* before you fly!\n\n3 - SRS is MANDATORY for OEO. The communications plan is fully detailed in the Briefing Images, you don't have to be vocal, but it REALLY helps to be listening!\n\nWe hope you enjoy your stay, best of luck and happy flying!", 30, 1)
			else
				return
		end
end

world.addEventHandler(WelcomeMessage)