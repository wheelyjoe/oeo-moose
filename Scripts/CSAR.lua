SpawnPilot = SPAWN:New("GroundedPilot")
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
                                                                                
  
local function CSARSearch(pilot)  

  local VolRescue =
   {
   id = world.VolumeType.SPHERE,
   params =
    {
    point = pilot:getPosition().p,
    radius = 250
    }
   }
  world.searchObjects(Object.Category.UNIT, VolRescue, ifFoundCSAR)


end

function spawnPilotCSAR(Vec2Location)
  local CSARSpawn = SpawnPilot:SpawnFromVec2(Vec2Location)
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
    local spawnedPilot = spawnPilotCSAR(roadLocationVec2)
    env.info(NumberCSARMissions)
    CSARPilots[NumberCSARMissions] = spawnedPilot
    CSARBeacons[NumberCSARMissions] = CSARPilots[NumberCSARMissions]:GetBeacon()
    local ADFFreq = math.random(190,1750)
    CSARBeacons[NumberCSARMissions]:RadioBeacon("SOS.ogg", ADFFreq , radio.modulation.AM, 25, 45*60)
    trigger.action.outTextForCoalition(2, playerName.." has been hit and is going down! His wingman has reported he sees a good chute. A CSAR Mission is now available to rescue them. Thier ADF Beacon in on ".. ADFFreq.. " AM", 30, 1)
    trigger.action.outSoundForCoalition(2, "RadioClick.ogg")
    trigger.smoke(CSARLocationVec3, 4)
    
    
    SchedulerID = SchedulerObject:Schedule({}, CSARSearch, {CSARPilots[NumberCSARMissions]} , 10, 60, 0, 45*60 )
    
    
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