-- OEO CSAR --

local SpawnDownedPilot = SPAWN:New("DownedPilot")
NumberCSARMissions = 0
CSARPilotsOnBoard = {}
NewCSARMission = {}
CSARDropoff = {}
ActiveCSARFrequencies = {}



function NewCSARMission:onEvent(event)

	--env.info("LIVES: Starting New CSAR Mission Function.")
	
	if event.initiator == nil
		then
			return
	elseif event.id == world.event.S_EVENT_EJECTION and event.initiator and event.initiator:getPlayerName() ~= nil and event.initiator:inAir() == true
		then
			NumberCSARMissions = NumberCSARMissions + 1  
			local EjectedPlayer = event.initiator
			local EjectedPlayerVec3 = EjectedPlayer:getPoint()
			local EjectedPlayerCoordinate = COORDINATE:NewFromVec3(EjectedPlayerVec3)
			local NearestRoad = EjectedPlayerCoordinate:GetClosestPointToRoad()
			local NearestRoadVec2 = NearestRoad:GetVec2() 
			local SpawnedPilot = SpawnDownedPilot:SpawnFromVec2(NearestRoadVec2)
			local SpawnedPilotPosition = SpawnedPilot:GetVec3()
			local PilotFrequency = math.random(45, 69)  
			local FreqForMessage = event.initiator:getPlayerName()..": "..PilotFrequency..".00 mHz FM"
			ActiveCSARFrequencies[#ActiveCSARFrequencies + 1] = FreqForMessage
			PilotFrequency = PilotFrequency*1000000
			local setFrequency = { 
				id = 'SetFrequency', 
				params = {
					frequency = PilotFrequency,
					modulation = radio.modulation.FM, 
				} 
			}
			local DownedPilot = Group.getByName('DownedPilot#00' ..NumberCSARMissions)
			local DownedPilotUnit = DownedPilot:getUnit(1)
			local DownedPilotPos = DownedPilotUnit:getPoint()
			local DownedPilotController = Group.getController(DownedPilot)
			DownedPilotController:setCommand(setFrequency)
			trigger.action.outTextForCoalition(2, EjectedPlayer:getPlayerName().." has been hit and is going down! Initial reports suggest a good chute, and a CSAR mission is being readied to rescue him. Use the F10 menu for more information.", 20, 1)
			local foundObjects = {}
			timer.scheduleFunction(CSARAreaSearch, {DownedPilotUnit, foundObjects, DownedPilot, FreqForMessage}, timer.getTime()+ 10)
		end
		
	--env.info("LIVES: Ending New CSAR Mission Function.")
	
end

function CSARAreaSearch(ParamTable)

	--env.info("LIVES: Starting CSAR Search Function.")
	
	local Pilot = ParamTable[1]
	local foundObjects = ParamTable[2]
	local PilotPosition = Pilot:getPoint()
	local PilotGroup = ParamTable[3]
	local ActiveFrequency = ParamTable[4]
	local CSARSearchZone = {
		id = world.VolumeType.SPHERE,
		params = {
			point = PilotPosition,
			radius = 100
			}
		}
	world.searchObjects(Object.Category.UNIT, CSARSearchZone, ifFoundUnit, foundObjects)
	if #foundObjects >= 1
		then
			foundObjectsName = foundObjects[1]
			PlayerCSARCount = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
				if PlayerCSARCount < 1
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 1)
						trigger.action.outTextForGroup(foundObjectsName, "You have successfully picked up the pilot! Get him back to the nearest NATO airbase or FARP to complete the CSAR mission!", 20, 1)
						trigger.action.deactivateGroup(PilotGroup)
						trigger.action.outTextForGroup(foundObjectsName, "Pilots on board: 1/4", 20, 1)
						for i = 1, #ActiveCSARFrequencies
							do
								local FreqToRemove = ActiveCSARFrequencies[i]
									if
										FreqToRemove == ActiveFrequency
											then
												table.remove(ActiveCSARFrequencies, i)
											
									end
							end
						local FirstFlagCheck = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
				elseif PlayerCSARCount == 1
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 2)
						trigger.action.outTextForGroup(foundObjectsName, "You have successfully picked up the pilot! Get him back to the nearest NATO airbase or FARP to complete the CSAR mission!", 20, 1)
						trigger.action.deactivateGroup(PilotGroup)
						trigger.action.outTextForGroup(foundObjectsName, "Pilots on board: 2/4", 20, 1)
						for i = 1, #ActiveCSARFrequencies
							do
								local FreqToRemove = ActiveCSARFrequencies[i]
									if
										FreqToRemove == ActiveFrequency
											then
												table.remove(ActiveCSARFrequencies, i)
											
									end
							end
						local SecondFlagCheck = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
				elseif PlayerCSARCount == 2
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 3)
						trigger.action.outTextForGroup(foundObjectsName, "You have successfully picked up the pilot! Get him back to the nearest NATO airbase or FARP to complete the CSAR mission!", 20, 1)
						trigger.action.deactivateGroup(PilotGroup)
						trigger.action.outTextForGroup(foundObjectsName, "Pilots on board: 3/4", 20, 1)
						for i = 1, #ActiveCSARFrequencies
							do
								local FreqToRemove = ActiveCSARFrequencies[i]
									if
										FreqToRemove == ActiveFrequency
											then
												table.remove(ActiveCSARFrequencies, i)
											
									end
							end
						local ThirdFlagCheck = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
				elseif PlayerCSARCount == 3
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 4)
						trigger.action.outTextForGroup(foundObjectsName, "You have successfully picked up the pilot and your heli is now full! Return to the nearest NATO airbase or FARP to drop the pilots off and complete the CSAR missions!", 20, 1)
						trigger.action.deactivateGroup(PilotGroup)
						for i = 1, #ActiveCSARFrequencies
							do
								local FreqToRemove = ActiveCSARFrequencies[i]
									if
										FreqToRemove == ActiveFrequency
											then
												table.remove(ActiveCSARFrequencies, i)
											
									end
							end
						local FourthFlagCheck = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
				elseif PlayerCSARCount > 3
					then
						trigger.action.outTextForGroup(foundObjectsName, "Your heli is already full! You must return to base before collecting any more pilots!", 20, 1)
				end
		else
			return timer.getTime() + 30
	end
	
	--env.info("LIVES: Ending CSAR Search function.")
	
end

function ifFoundUnit(foundItem, val)
	if foundItem:hasAttribute("Helicopters") and foundItem:getPlayerName() ~= nil and foundItem:inAir() == false
		then
			val[#val + 1] = foundItem:getGroup():getID()
	end
end

function CSARDropoff:onEvent(event)

	--env.info("LIVES: Starting CSAR Dropoff Function.")
	
	if event.initiator == nil
		then
			return
	elseif (event.id == world.event.S_EVENT_LAND and event.place:getTypeName() == "Al Minhad AB" and event.initiator:getPlayerName() ~= nil) or (event.id == world.event.S_EVENT_LAND and event.place:getTypeName() == "Al Dhafra AB" and event.initiator:getPlayerName() ~= nil) 
		or (event.id == world.event.S_EVENT_LAND and event.place:getTypeName() == "Stennis - airbase" and event.initiator:getPlayerName() ~= nil) or (event.id == world.event.S_EVENT_LAND and event.place:getTypeName() == "LHA_Tarawa - airbase" and event.initiator:getPlayerName() ~= nil) 
		or (event.id == world.event.S_EVENT_LAND and string.find(event.place:getName(), "FARP") and event.initiator:getPlayerName() ~= nil)
		then
			CheckCSARonBoard = trigger.misc.getUserFlag(event.initiator:getGroup():getID().."CSARCount")
				if CheckCSARonBoard > 0
					then
						LivesRemaining = LivesRemaining + CheckCSARonBoard
						LivesMIA = LivesMIA - CheckCSARonBoard
						trigger.action.outTextForGroup(event.initiator:getGroup():getID(), "You have successfully returned "..CheckCSARonBoard.." pilots to base! Remaining lives have been adjusted.", 30, 1)
						CheckCSARonBoard = 0
						trigger.action.setUserFlag(event.initiator:getGroup():getID().."CSARCount", 0)
				end
	end
	
	--env.info("LIVES: Ending CSAR Dropoff Function.")
	
end


PlayerGroupIDs = {}

function F10MenuOptions:onEvent(event)
    if event.id == world.event.S_EVENT_BIRTH and event.initiator and event.initiator:getPlayerName() ~= nil 
		then
			local PlayerID = event.initiator:getGroup():getID()
			if PlayerGroupIDs[PlayerID] == nil then
				PlayerGroupIDs[PlayerID] = true
				missionCommands.addCommandForGroup(PlayerID, "Team Lives Status", nil, PrintLives, PlayerID)
				missionCommands.addCommandForGroup(PlayerID, "Active CSAR Frequencies", nil, PrintCSARFrequencies, PlayerID)
        end
    end
end

function PrintCSARFrequencies(Player)
	if #ActiveCSARFrequencies < 1
		then
			trigger.action.outTextForGroup(Player, "There are currently no CSAR Missions available.", 10, 1)
	else
		trigger.action.outTextForGroup(Player, "Active CSAR Beacons\n" ..table.concat(ActiveCSARFrequencies, "\n"), 20, 1)
	end
end