-- Operation Enduring Odyssey Lives System --

-- Define Required Variables and Functions --
LivesRemaining = 500
LivesAirborne = 0
LivesLost = 0
LivesMIA = 0
LivesAWOL = 0
Takeoff = {}
Landing = {}
Death = {}
Eject = {}
Disconnect = {}
--Revived = {}
MissionFailure = {}

-- Define Global Variables that are Al Minhad and Al Dhafra --



-- Define Useful Functions for Amending Variable Values --

function PlayerTakeoff()
	LivesRemaining = LivesRemaining - 1
	LivesAirborne = LivesAirborne + 1
		if LivesRemaining < 0
			then
				LivesRemaining = 0
		end
end

function PlayerLand()
	LivesRemaining = LivesRemaining + 1
	LivesAirborne = LivesAirborne - 1
		if LivesAirborne < 0
			then
				LivesAirborne = 0
		end
end

function PlayerDie()
	LivesAirborne = LivesAirborne - 1
	LivesLost = LivesLost + 1
	if LivesLost < 0
		then
			LivesLost = 0
	end
end

function PlayerMIA()
	LivesMIA = LivesMIA + 1
	LivesAirborne = LivesAirborne - 1
		if LivesAirborne < 0
			then
				LivesAirborne = 0
		end
end

function PlayerRecovered()
	LivesLost = LivesLost - 1
	LivesRemaining = LivesRemaining + 1
end

function PlayerAWOL()
	LivesAirborne = LivesAirborne - 1
	LivesAWOL = LivesAWOL + 1
		if LivesAirborne < 0
			then
				LivesAirborne = 0
		end
end

function PlayerNotAWOL()
	LivesAWOL = LivesAWOL - 1
	LivesAirborne = LivesAirborne + 1
		if LivesAWOL < 0
			then
				LivesAWOL = 0
		end
end
	
-- F10 Menu Check Remaning Lives --

function PrintLives()
	trigger.action.outTextForCoalition(2,"Operation Enduring Odyssey Lives Status \n\nLives Remaining: " ..LivesRemaining.. " \nAirborne Pilots: " ..LivesAirborne.. "\nPilots MIA: " ..LivesMIA.. "\nLives Lost: " ..LivesLost, 10, 1)
end

function F10CheckLives()
	local PrintLivesToPlayer = missionCommands.addCommandForCoalition(2, "Team Lives Status", nil, PrintLives, {})
end

F10CheckLives()

-- Define Actions on Player Events --

function Takeoff:onEvent(event)
	if (event.id == 3 and event.place:getTypeName() == "Al Minhad AB" and event.initiator:getPlayerName() ~= nil) or (event.id == 3 and event.place:getTypeName() == "Al Dhafra AB" and event.initiator:getPlayerName() ~= nil) or (event.id == 3 and event.place:getTypeName() == "Stennis - airbase" and event.initiator:getPlayerName() ~= nil) or (event.id == 3 and event.place:getTypeName() == "LHA_Tarawa - airbase" and event.initiator:getPlayerName() ~= nil)
		then
			PlayerTakeoff()
			local DepartedPilot = event.initiator
			trigger.action.outTextForGroup(DepartedPilot:getGroup():getID(), "You have taken off and a life has been removed from the team. Land safely at either Al Dhafra, Al Minhad or the Carrier to return your life to the pool. Good luck!", 10, 1)
			--env.info("TAKEOFF EVENT RUN")
	elseif event.id == 3 and event.initiator:getPlayerName() ~= nil
		then
			PlayerNotAWOL()
			local NotAWOLPilot = event.initiator
			trigger.action.outTextForGroup(NotAWOLPilot:getGroup():getID(), "You have taken off again and are no longer considered AWOL. Return to Al Dhafra, Al Minhad or the Carrier to return your life to the pool.", 30, 1)
		end
end

function Landing:onEvent(event)
	if (event.id == 4 and event.place:getTypeName() == "Al Minhad AB" and event.initiator:getPlayerName() ~= nil) or (event.id == 4 and event.place:getTypeName() == "Al Dhafra AB" and event.initiator:getPlayerName() ~= nil) or (event.id == 4 and event.place:getTypeName() == "Stennis - airbase" and event.initiator:getPlayerName() ~= nil) or (event.id == 3 and event.place:getTypeName() == "LHA_Tarawa - airbase" and event.initiator:getPlayerName() ~= nil)
		then 
			--env.info("LANDING DETECTED")
			local LandedPilot = event.initiator
			timer.scheduleFunction(LandingLifeCheck, LandedPilot, timer.getTime()+1)
			--env.info("SCHEDULED CHECK FUNCTION")
	elseif event.id == 4 and event.initiator:getPlayerName() ~= nil
		then
			--env.info("LANDING AT WRONG AIRBASE DETECTED")
			local LandedPilot = event.initiator
			timer.scheduleFunction(AWOLLandingLifeCheck, LandedPilot, timer.getTime()+1)
			--env.info("SCHEDULED AWOL CHECK FUNCTION")
	end
end

function LandingLifeCheck(PilotOnGround)
	--env.info("RUNNING LIFE CHECK")
	local PilotsLife = PilotOnGround:getLife()
	--env.info(PilotsLife)
		if PilotsLife > 0
			then
				--env.info("PLAYER IS ALIVE")
				PlayerLand()
				trigger.action.outTextForGroup(PilotOnGround:getGroup():getID(), "Welcome back! You have landed safely and your life has been returned to the team. Great job!", 10, 1)
				--env.info("LANDING EVENT RUN")
			end
end
		
function AWOLLandingLifeCheck(PilotOnGround)
	--env.info("RUNNING AWOL LIFE CHECK")
	local PilotsLife = PilotOnGround:getLife()
	--env.info(PilotsLife)
		if PilotsLife > 0
			then
				--env.info("PLAYER IS AWOL")
				PlayerAWOL()
				trigger.action.outTextForGroup(PilotOnGround:getGroup():getID(), "You have successfully landed, but at the wrong airbase! You are currently considered AWOL. Return to either Al Dhafra, Al Minhad or the Carrier to return your life to the pool.", 30, 1)
				--env.info("AWOL EVENT RUN")
			end
end
		
function Death:onEvent(event)
	if event.id == 9 and event.initiator:getPlayerName() ~= nil
		then
			PlayerDie()
			local KilledPilot = event.initiator
			trigger.action.outTextForGroup(KilledPilot:getGroup():getID(), "You have been killed in action. Your life has been added to the death toll. Be more careful next time!", 10, 1)
			--env.info("DEATH EVENT RUN")
		end
end

function Eject:onEvent(event)
	if event.id == 6 and event.initiator:getPlayerName() ~= nil
		then
			PlayerMIA()
			local EjectedPilot = event.initiator
			trigger.action.outTextForCoalition(2, EjectedPilot:getPlayerName().." has ejected safely and a CSAR mission is available to rescue them! Use the F10 Menu for more information. (STILL INACTIVE)", 10, 1) -- This line will be removed as Ali's CSAR Script sends the CSAR message.
			--env.info("EJECT EVENT RUN")
		end
end

--[[function Revived:onEvent(event) --ALI ASSURES ME HE WILL DEAL WITH THIS IN HIS CSAR SCRIPT.wav
	if (CSAR Script Mission complete = true)
		then
			PlayerRecovered()
			trigger.action.outTextForGroup(RECOVERYPILOTSNAME, "You have successfully returned a downed pilot to base, and a life has been added to the pool. Great job!", 10, 1)
			--env.info("RECOVERY EVENT RUN")
		end
end]]--

function Disconnect:onEvent(event)
	if event.id == 20 and event.initiator:inAir() == true
		then
			PlayerDie()
			--env.info("DISCONNECT EVENT RUN")
		end
end

-- Define Function for actioning Mission Failure --

function RestartMission()
	net.load_next_mission()
end

function MissionFailure:onEvent(event)
	if event.id == 9 and event.initiator:getPlayerName() ~= nil and LivesLost > 500
		then
			trigger.action.outTextForCoalition(2, "The death toll of Operation Enduring Odyssey has soared too high. Public opinion of the Operation has fallen and units are being pulled out of the Persian Gulf. Mission Failed.", 60, 1)
			timer.scheduleFunction(RestartMission, {}, timer.getTime()+60)
		end
end

world.addEventHandler(Takeoff)
world.addEventHandler(Landing)
world.addEventHandler(Death)
world.addEventHandler(Eject)
--world.addEventHandler(Revived)
world.addEventHandler(MissionFailure)
world.addEventHandler(Disconnect)