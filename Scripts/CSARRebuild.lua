-- Operation Enduring Odyssey CSAR Script --

-- Define Required Variables --

local SpawnDownedPilot = SPAWN:New("DownedPilot")
NumberCSARMissions = 0
CSARPilots = {}
CSARBeacons = {}
CurrentCSARReturns = {}
NewCSARMission = {}

-- Function to Detect Player Ejections and Create CSAR Mission --

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
			
			-- Pilot Spawned at Nearest Road, now set Unit Commands --
			
			--Setup Set Frequency Command --
			
			local DownedPilotFrequency = math.random(45, 69)
					DownedPilotFrequency = DownedPilotFrequency*1000000
			env.info("SET FREQUENCY NUMBER")
			local DownedPilotSetFrequency = {
				id = 'SetPilotFrequency',
				params = {
					frequency = DownedPilotFrequency,
					modulation = radio.modulation.FM,
				}
			}
			env.info("SETUP SET FREQUENCY COMMAND")
			
			-- Set Pilot's Frequency using above command --
			
			local DownedPilot = Group.getByName('DownedPilot#00' ..NumberCSARMissions)
			env.info("FOUND OUR GUY")
			local DownedPilotController = Group.getController(DownedPilot)
			env.info("GOT HIS CONTROLLER")
			DownedPilotController:setCommand(DownedPilotSetFrequency)
			env.info("SET HIS FREQ")
			
			-- Send Message to Coalition --
			trigger.action.outTextForCoalition(2, DownedPilot:getPlayerName().." has been hit and is going down! Initial reports suggest a good chute, and a CSAR mission is being readied to rescue him. Use the F10 menu for more information.", 20, 1)
			trigger.action.outTextForCoalition(2, "ADF Beacon on " ..DownedPilotFrequency, 20, 1)
			
	end
end
			
			












world.addEventHandler(NewCSARMission)