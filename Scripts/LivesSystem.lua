-- Operation Enduring Odyssey Lives System Initial Draft --

-- Define Required Variables and Functions --
LivesRemaining = 300
LivesAirborne = 0
LivesLost = 0
Takeoff = {}
Landing = {}
Death = {}
Eject = {}
--Revived = {}
MissionFailure = {}

-- Define Global Variables that are Al Minhad and Al Dhafra --



-- Define Useful Functions for Amending Variable Values --

function PlayerTakeoff()
	LivesRemaining = LivesRemaining - 1
	LivesAirborne = LivesAirborne + 1
end

function PlayerLand()
	LivesRemaining = LivesRemaining + 1
	LivesAirborne = LivesAirborne - 1
end

function PlayerDie()
	LivesAirborne = LivesAirborne - 1
	LivesLost = LivesLost + 1
	if LivesLost < 0
		then
			LivesLost = 0
	end
end

function PlayerRecovered()
	LivesLost = LivesLost - 1
	LivesRemaining = LivesRemaining + 1
end

-- Define Simple Functions for Amending Arithmetic Values of Variables by 1 --

function LivesRemainingUp()
	LivesRemaining = LivesRemaining - 1
end

function LivesRemainingDown()
	LivesRemaining = LivesRemaining + 1
end

function LivesAirborneUP()
	LivesAirborne = LivesAirborne + 1
end

function LivesAirborneDown()
	LivesAirborne = LivesAirborne - 1
end

function LivesLostUp()
	LivesLost = LivesLost + 1
end

function LivesLostDown()
	LivesLost = LivesLost - 1
end

-- F10 Menu Check Remaning Lives --

function PrintLives()
	trigger.action.outTextForCoalition(2,"Operation Enduring Odyssey Lives Status \n\nLives Remaining: " ..LivesRemaining.. " \nAirborne Pilots: " ..LivesAirborne.. "\nLives Lost: " ..LivesLost, 10, 1)
end

function F10CheckLives()
	local PrintLivesToPlayer = missionCommands.addCommandForCoalition(2, "Team Lives Status", nil, PrintLives, {})
end

F10CheckLives()

-- Define Actions on Player Events --

function Takeoff:onEvent(event)
	if event.id == 3 and event.initiator ~= nil
		then
			PlayerTakeoff()
			local DepartedPilot = event.initiator
			trigger.action.outTextForGroup(DepartedPilot:getGroup():getID(), "You have taken off and a life has been removed from the team. Land safely at either Al Dhafra, Al Minhad or the Carrier to return your life to the pool. Good luck!", 10, 1)
			env.info("TAKEOFF EVENT RUN")
		end
end

--[[function Landing:onEvent(event) -- Check Surface Version
		if event.id == 4 and event.initiator ~= nil
		then 
			--env.info("LANDING DETECTED")
			local LandedPilot = event.initiator
			--env.info("INITIATOR SET")
			local LandingPoint = LandedPilot:getPoint()
			--env.info("GOT LANDING COORDINATES")
			local LandingPointSurface = land.getSurfaceType(LandingPoint)
			--env.info("GOT LANDING SURFACE TYPE")
			env.info("LANDING SURFACE = "  .. LandingPointSurface)
				if LandingPointSurface == 5
					then
						PlayerLand()
						local LandedPilot = event.initiator
						trigger.action.outTextForGroup(LandedPilot:getGroup(), "Welcome back! You have landed safely and your life has been returned to the team. Great job!"  10, 1)
						env.info("LANDING EVENT RUN")
				end
		end
end]]--

function Landing:onEvent(event) -- Timer Check Version
		if event.id == 4 and event.initiator ~= nil
		then 
			env.info("LANDING DETECTED")
			local LandedPilot = event.initiator
			LandedPilotCategory = LandedPilot:getCategory()
			env.info(LandedPilotCategory)
			timer.scheduleFunction(LandingLifeCheck, {LandedPilot}, timer.getTime()+3)
			env.info("SCHEDULED CHECK FUNCTION")
			end
end


function LandingLifeCheck(LandedPilot)
	env.info("RUNNING LIFE CHECK")
	local PilotExists = LandedPilot.isExist()
		if
			PilotExists == nil
				then
					env.info("PILOT EXISTS IS NIL")
		else if 
			PilotExists == true
				then
					env.info("PILOT EXISTS")
		else if
			PilotsExists == false
				then
					env.info("PILOT IS DEAD")
			end
		end
	end
end
	--[[local PilotsLife = Unit.getLife(PilotOnGround)
	--env.info(PilotsLife)
		--if PilotsLife == nil
			--then
				--env.info("LIFE IS NIL")
		else if PilotsLife > 0
			then
				env.info("PLAYER IS ALIVE")
				PlayerLand()
				trigger.action.outTextForGroup(PilotOnGround:getGroup(), "Welcome back! You have landed safely and your life has been returned to the team. Great job!", 10, 1)
				env.info("LANDING EVENT RUN")
			end
		end
end--]]

function Death:onEvent(event)
	if event.id == 9 and event.initiator ~= nil
		then
			PlayerDie()
			local KilledPilot = event.initiator
			trigger.action.outTextForGroup(KilledPilot:getGroup():getID(), "You have been killed in action. Your life has been added to the death toll. Be more careful next time!", 10, 1)
			env.info("DEATH EVENT RUN")
		end
end

function Eject:onEvent(event)
	if event.id == 6 and event.initiator ~= nil
		then
			PlayerDie()
			local EjectedPilot = event.initiator
			trigger.action.outTextForCoalition(2, EjectedPilot:getPlayerName().." has ejected. CSAR Available.", 10, 1) -- This line will be removed as Ali's CSAR Script sends the CSAR message.
			env.info("EJECT EVENT RUN")
		end
end

--[[function Revived:onEvent(event) --ALI ASSURES ME HE WILL DEAL WITH THIS IN HIS CSAR SCRIPT.wav
	if (CSAR Script Mission complete = true)
		then
			PlayerRecovered()
			trigger.action.outTextForGroup(RECOVERYPILOTSNAME, "You have successfully returned a downed pilot to base, and a life has been added to the pool. Great job!", 10, 1)
			env.info("RECOVERY EVENT RUN")
		end
end]]--

-- Define Function for actioning Mission Failure --

function RestartMission()
	net.load_next_mission()
end

function MissionFailure:onEvent(event)
	if event.id == 9 and event.initiator ~= nil and LivesLost > 300
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