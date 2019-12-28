local SpawnPilot = SPAWN:New("GroundedPilot")
NumberCSARMissions = 0
CSARPilots = {}
CSARBeacons = {}
CurrentCSARReturns = {}
SpawnCSAR = {}
--CSARPickup = {}
CSARDropoff = {}

-- Function to Detect Player Ejections and Create CSAR Mission --

function SpawnCSAR:onEvent(event)
  if event.id == 6 and event.initiator:getPlayerName() ~= nil 
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
	local FreqForMessage = ADFFreq
    ADFFreq = ADFFreq*1000000
    local setFrequency = { 
      id = 'SetFrequency', 
      params = {
        frequency = ADFFreq,
        modulation = radio.modulation.FM, 
      } 
    }
    local downedPilot = Group.getByName('GroundedPilot#00' ..NumberCSARMissions)
    local downedUnit = downedPilot:getUnit(1)
    local pilotPos = downedUnit:getPoint()
    local pilotController = Group.getController(downedPilot)
--    pilotController:setCommand(ActivateBeacon)
    pilotController:setCommand(setFrequency)
    env.info("Beacon Activated")
    trigger.action.outTextForCoalition(2, playerName:getPlayerName().." has been hit and is going down! His wingman reports he sees a good chute. A CSAR Mission is now available to rescue them, use the F10 menu for more information. His beacon is active on "..FreqForMessage.. ".00 mHz FM.", 30, 1)
    trigger.action.outSoundForCoalition(2, "RadioClick.ogg")
    trigger.action.smoke(CSARPos, 4)
    timer.scheduleFunction(CSARSearch, downedUnit, timer.getTime()+10)
  end
end

-- Function to look for Units in the Radius of the Downed Pilot --

function CSARSearch(pilot)  

  env.info("Searching...")
  if pilot == nil then
  
    env.warning("Pilot is nil value")
  
  end  
  env.info("Pilot is not nil")
  env.info("Seach point set...")
  --env.info("x: " ..pilot[1])
  --env.info("y: " ..pilot[2])
  local downedUnitPoint = pilot:getPoint()
  local VolRescue =
   {
   id = world.VolumeType.SPHERE,
   params =
    {
    point = downedUnitPoint,
    radius = 10000
    }
   }
   env.info("Volume initiated...")
   world.searchObjects(Object.Category.UNIT, VolRescue, ifFoundCSAR)
   env.info("No more items found....")
  if pilot ~= nil then
  
    return (timer.getTime()+60)

   else
   
    return nil
   
   end
end

-- Function upon finding unit in Range --

local ifFoundCSAR = function(foundItem, val)
 
 env.info("Found unit")                               
-- env.info("Search found groupID: " ..foundItem:getName())
 coalition = foundItem:getCoalition()
-- env.info("It is part of Coalition " ..coalition)
 
 if coalition == 2 then
 
  if foundItem:hasAttribute("HELICOPTER") then
        env.info("Of type helicopter on blue")
        if foundItem.getVelocity < 10 and  (foundItem.getPoint().y - land.getHeight({x=pos.x, y = pos.z})) < 5 then

          local MessagePickup = MESSAGE:New("Downed pilot picked up. RTB safely to complete CSAR mission."):ToClient(event.initiator)
        end
        
    end   
        
  end 
    
end      
                                                                                
  


function spawnPilotCSAR(Vec2Location)
  local CSARSpawn = SpawnPilot:SpawnFromVec2(Vec2Location)
  CSARSpawn.getUnit(1)
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