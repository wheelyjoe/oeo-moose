-- Operation Enduring Odyssey CSAR Script --

local SpawnDownedPilot = SPAWN:New("DownedPilot")
NumberCSARMissions = 0
CSARPilotsOnBoard = {}
NewCSARMission = {}
CSARDropoff = {}

function NewCSARMission:onEvent(event)
	if event.id == 6 and event.initiator:getPlayerName() ~= nil
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
			local FreqForMessage = PilotFrequency
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
			trigger.action.outTextForCoalition(2, "ADF Beacon on " ..FreqForMessage.. ".00 mHz FM", 20, 1)
			local foundObjects = {}
			timer.scheduleFunction(CSARAreaSearch, {DownedPilotUnit, foundObjects, DownedPilot}, timer.getTime()+ 10)
		end
end

function CSARAreaSearch(ParamTable)
	env.info("Entered Search Function")
	local Pilot = ParamTable[1]
	local foundObjects = ParamTable[2]
	local PilotPosition = Pilot:getPoint()
	local PilotGroup = ParamTable[3]
	local CSARSearchZone = {
		id = world.VolumeType.SPHERE,
		params = {
			point = PilotPosition,
			radius = 100
			}
		}
	world.searchObjects(Object.Category.UNIT, CSARSearchZone, ifFoundUnit, foundObjects)
	env.info(#foundObjects)
	if #foundObjects >= 1
		then
			foundObjectsName = foundObjects[1]
			trigger.action.outTextForCoalition(2, "You have successfully picked up the pilot! Get him back to the nearest airbase or FARP to complete the CSAR mission!", 20, 1)
			trigger.action.deactivateGroup(PilotGroup)
			PlayerCSARCount = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
			env.info("FLAG SET TO" ..PlayerCSARCount)
				if PlayerCSARCount < 1
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 1)
						trigger.action.outTextForCoalition(2, "Set flag to 1", 10, 1)
						PlayerCSARCount = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
						env.info("FLAG SET TO" ..PlayerCSARCount)
				elseif PlayerCSARCount == 1
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 2)
						trigger.action.outTextForCoalition(2, "Set flag to 2", 10, 1)
				elseif PlayerCSARCount == 2
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 3)
						trigger.action.outTextForCoalition(2, "Set flag to 3", 10, 1)
				elseif PlayerCSARCount == 3
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 4)
						trigger.action.outTextForCoalition(2, "Your heli is now full! Return to the nearest airbase or FARP to drop the pilots off and complete the CSAR missions!", 20, 1)
				elseif PlayerCSARCount > 3
					then
						trigger.action.outTextForCoalition(2, "Your heli is already full! You must return to base before collecting any more pilots!", 20, 1)
				end
		else
			trigger.action.outTextForCoalition(2, "DIDNT FIND ANYTHING", 20, 1)
			return timer.getTime() + 10
	end
end

function ifFoundUnit(foundItem, val)
	if foundItem:hasAttribute("Helicopters") and foundItem:getPlayerName() ~= nil and foundItem:inAir() == false
		then
			val[#val + 1] = foundItem:getPlayerName()
	end
end

function CSARDropoff:onEvent(event)
	if event.id == 4 and event.initiator:getPlayerName() ~= nil
		then
			CheckCSARonBoard = trigger.misc.getUserFlag(event.initiator:getPlayerName().."CSARCount")
				if CheckCSARonBoard > 0
					then
						trigger.action.outTextForCoalition(2, "You have successfully returned the downed Pilot to base! His life has been returned to the pool!", 30, 1)
				end
	end
end

world.addEventHandler(NewCSARMission)
world.addEventHandler(CSARDropoff)