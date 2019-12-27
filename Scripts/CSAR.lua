local SpawnPilot = SPAWN:New("GroundedPilot")
NumberCSARMissions = 0
CSARPilots = {}
CSARBeacons = {}
CurrentCSARReturns = {}
SpawnCSAR = {}
--CSARPickup = {}
CSARDropoff = {}

local function ifFoundCSAR(foundItem, val)
                                
-- env.info("Search found groupID: " ..foundItem:getName())
 coalition = foundItem:getCoalition()
-- env.info("It is part of Coalition " ..coalition)
 
 if coalition == 2 then
 
  if foundItem:hasAttribute("HELICOPTER") then
        
        if foundItem.getVelocity < 10 and  (foundItem.getPoint().y - land.getHeight({x=pos.x, y = pos.z})) < 5 then

          MessagePickup = MESSAGE:New("Downed pilot picked up. RTB safely to complete CSAR mission."):ToClient(event.initiator)
          CSARBeacons[i]:destroy()
          CSARPilots[i]:destroy()
          CSARZone[i]:destroy()
          CurrentCSARReturns[#CurrentCSARReturns+1] = event.initiator
        end
        
    end   
        
  end 
    
end      
                                                                                
  
local function CSARSearch(pilotPos)  


  local VolRescue =
   {
   id = world.VolumeType.SPHERE,
   params =
    {
    point = pilotPos,
    radius = 250
    }
   }
  world.searchObjects(Object.Category.UNIT, VolRescue, ifFoundCSAR)


end

function spawnPilotCSAR(Vec2Location)
  local CSARSpawn = SpawnPilot:SpawnFromVec2(Vec2Location)
  CSARSpawn.getUnit(1)
end

function SpawnCSAR:onEvent(event)
  if event.id == 6 and event.initiator ~= nil 
  then
    NumberCSARMissions = NumberCSARMissions + 1  
    local lostUnit = event.initiator
    local playerName = event.initiator 
    local CSARLocationVec3 = lostUnit:getPoint()
    local CSARLocationCoord = COORDINATE:NewFromVec3(CSARLocationVec3)
    local roadLocation = CSARLocationCoord:GetClosestPointToRoad()
    local roadLocationVec2 = roadLocation:GetVec2() 
    local spawnedPilot = SpawnPilot:SpawnFromVec2(roadLocationVec2)
    local CSARPos = roadLocation:GetVec3()
    env.info(NumberCSARMissions)
    local ADFFreq = math.random(45, 69)  
    ADFFreq = ADFFreq*1000000
    local activateBeacon = { 
      id = 'ActivateBeacon', 
      params = { 
      type = 1084, 
      system = 7, 
      name = "Downed pilot " ..NumberCSARMissions, 
      callsign = "SOS", 
      frequency = 040000000, 
      } 
    }
    local setFrequency = { 
      id = 'SetFrequency', 
      params = {
        frequency = ADFFreq,
        modulation = radio.modulation.FM, 
      } 
    }
    local downedPilot = Group.getByName('GroundedPilot#00' ..NumberCSARMissions)
    local pilotController = Group.getController(downedPilot)
--    pilotController:setCommand(ActivateBeacon)
    pilotController:setCommand(setFrequency)
    env.info("Beacon Activated")
    trigger.action.outTextForCoalition(2, playerName:getPlayerName().." has been hit and is going down! His wingman reports he sees a good chute. A CSAR Mission is now available to rescue them, use the F10 menu for more information. His beacon is "..ADFFreq, 30, 1)
    trigger.action.outSoundForCoalition(2, "RadioClick.ogg")
    trigger.action.smoke(CSARPos, 4)
    SCHEDULER:New(spawnedPilot, CSARSearch, {CSARPos}, 10, 60, 0, 45*60)
        
    
  end
end

--function CSARPickup:onEvent(event)
--  if event.id == 4 and event.initiator ~= nil and event.initiator.Category == "HELICOPTER"
--  then
--    if #CSARZones ~= 0 then
--
--      for i = 1, #CSARZones do
--
--        if(CSARZone[i].isVec3InZone(event.initiator.getPosition().p)) then
--

--
--        end
--      end
--
--    end
--  end
--end

function CSARDropoff:onEvent(event)
  if event.id == 4 and event.initiator ~= nil and event.initiator.Category == "HELICOPTER" then
    if #CurrentCSARReturns == 0 then 
      return 
    end
    
    for i = 1, #CSAR do
      if CurrentCSARReturns[i] == event.initiator then
    
        MessagePickup = MESSAGE:New("Downed pilot returned to base. A life has been returned to the pool."):ToClient(event.initiator)
        
    
      end 
      
     end
     
  end

end

world.addEventHandler(SpawnCSAR)
--world.addEventHandler(CSARPickup)
world.addEventHandler(CSARDropoff)