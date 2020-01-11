-- RADAR DETECITON DOESN'T SEEM TO BE WORKING -- 


redEWR = {}
redSAMS = {}
foundSAMS = {}
offRedSAMS = {}
onRedSAMS = {}
detectedUnits = {}

local function getDistance (point1, point2)

  --  env.info("Calculating Distance")
  local x1 = point1.x
  local y1 = point1.y
  local z1 = point1.z
  local x2 = point2.x
  local y2 = point2.y
  local z2= point2.z

  local dX = math.abs(x1-x2)
  local dY = math.abs(y1-y2)
  local dZ = math.abs(z1-z2)
  local distance = math.sqrt(dX*dX + dZ*dZ)

  return distance

end

local function isSAMOn(SAMGroup)
  --    env.info("Is SAM on?")
  --    env.info("Some are")
  for i = 1, #onRedSAMS do
    if SAMGroup:getName() == onRedSAMS[i] then
      --      env.info("This one is, returning 1")
      return 1

    end
  end
  --  env.info("This one isn't, returning 0")
  return 0
end

local function isSAMOff(SAMGroup)
  --  env.info("Is SAM off?")
  --  env.info("Some are")
  for i = 1, #offRedSAMS do
    if SAMGroup:getName() == offRedSAMS[i] then
      --      env.info("This one is, returning 1")
      return 1

    end
  end
  --  env.info("This one isn't, returning 0")
  return 0

end

local function disableSAMRadarSingle(SAMUnit)

  env.info("Disable radar?")
  local SAMGroup = SAMUnit:getGroup()
  local SAMController = SAMGroup:getController()
  local SAMDetectedTargets = {}
  SAMDetectedTargets = SAMController:getDetectedTargets()
  if SAMDetectedTargets ~= nil then

    for i = 1, #SAMDetectedTargets do
      if SAMDetectedTargets[i].object:getCoalition() == 2 then
        env.info("Group can still see blues, staying on...")
        return timer.getTime()+60
      end
    end
  end
  if isSAMOff(SAMGroup) == 1 then
    env.info("Already off - Doing nothing")
    return
  end
  if isSAMOn(SAMGroup) == 1 then
    --    env.info("On - Turning off")
    SAMController:setOption(AI.Option.Ground.id.ALARM_STATE,1)
    onRedSAMS[i] = nil
    offRedSAMS[#offRedSAMS+1] = SAMGroup:getName()
    env.info("Radar turned off")
  end

  --  env.info("disableSAMRadarSingle ended")
end

local function enableSAMRadarSingle(SAMUnit)

    env.info("Enabling radar")
  local SAMGroup = SAMUnit:getGroup()
  local SAMController = SAMGroup:getController()
  if isSAMOn(SAMGroup) == 1 then
        env.info("Already on - Doing nothing")
    return
  end

  if isSAMOff(SAMGroup) == 1 then
        env.info("Off - Turning on")
    SAMController:setOption(AI.Option.Ground.id.ALARM_STATE,2)
        env.info("Turned on")
    for i = 1, #offRedSAMS do
      if offRedSAMS[i] == SAMGroup:getName() then
        offRedSAMS[i] = nil
      end
    end
    for j = 1, #onRedSAMS do

      if onRedSAMS[j] == nil then

        onRedSAMS[j] = SAMGroup:getName()

      end

    end
    onRedSAMS[#onRedSAMS+1] = SAMGroup:getName()
  end

  env.info("enableSAMRadarSingle ended")
  timer.scheduleFunction(disableSAMRadarSingle,SAMUnit, timer.getTime()+60) 

end

local function PopulateEWRList()
  redEWR = {}
  for i, gp in pairs(coalition.getGroups(1), 2) do
    --    env.info("Got Red group ID:  ".. gp:getName().. " of type Ground")
    for index, data in pairs(gp:getUnits()) do
      if data:hasAttribute("EWR") then
        local isInGroup = 0
        for j = 1, #redEWR do

          if redEWR[j] == gp:getName() then

            isInGroup = 1
             --           env.info("Group already in EWR table, not adding...")
          end
        end
        if isInGroup == 0 then
             --      env.info("Group isn't already in EWR table, adding...")
          redEWR[#redEWR+1] = gp:getName()
             --       env.info("There are now " ..#redEWR.." in the EWR table.")

        end
      end
    end
  end
  env.info("EWR List populated, it contains " ..#redEWR.." units")
end

local function ifFoundCloseSAM(foundItem, plane)
--    env.info("Unit Found")
  if foundItem:hasAttribute("SAM SR") then
--        env.info("It's a search radar")
    local rangeMax = 0
    local SAMGroup = foundItem:getGroup()
    --    env.info("Got group")
    if isSAMOff(SAMGroup) then
      --      env.info("It's turned off")
      local SAMController = Group.getController(SAMGroup)
      --      env.info("Got controller")
      local SAMGroupUnits = SAMGroup:getUnits()
      --      env.info("Got units")
      for i = 1, #SAMGroupUnits do
        if SAMGroupUnits[i]:getAmmo() then
          --          env.info("It has ammo")
          local ammoType = SAMGroupUnits[i]:getAmmo() 
          for _, item in pairs(ammoType) do
            if item.desc.rangeMaxAltMax then
              if (item.desc.rangeMaxAltMax) > rangeMax then
                rangeMax = (item.desc.rangeMaxAltMax)
                --                env.info("The longest range missile in the site has a range of: "..rangeMax)
              end 
            end       
          end
        end
      end
      local distanceFromPlaneToSAMSite = getDistance(plane:getPoint(), foundItem:getPoint())
      if rangeMax > distanceFromPlaneToSAMSite then
        enableSAMRadarSingle(foundItem)
                env.info("Plane is "..distanceFromPlaneToSAMSite.." from the site, and the range of the site is "..rangeMax)
      end
    end
  end
end

local function ifFoundVisual(foundItem, SAMGroup)

--  env.info("I See something...")

  if foundItem:getCoalition(2) then

--   env.info(SAMGroup:getName().." spotted target visually, activating!")
    enableSAMRadarSingle(SAMGroup:getUnit(1))    

  end

end

local function populateSAMList()
  redSAMS = {}
  for i, gp in pairs(coalition.getGroups(1), 2) do
    for index, data in pairs(gp:getUnits()) do
      if data:hasAttribute("SAM SR") then
        local isInGroup = 0
        for j = 1, #redSAMS do
          if redSAMS[j] == gp:getName() then
            isInGroup = 1
          end
        end
        if isInGroup == 0 then
          redSAMS[#redSAMS+1] = gp:getName()

        end
      end
    end
  end
  env.info("SAM List populated")
end

local function disableAllSAMRadars()
  for i, gp in pairs(coalition.getGroups(1), 2) do
    for index, data in pairs(gp:getUnits()) do
      if data:hasAttribute("SAM SR") then
        local isInGroup = 0
        for j = 1, #redSAMS do
          if redSAMS[j] == gp:getName() then
            isInGroup = 1       
          end
        end
        if isInGroup == 0 then      
          redSAMS[#redSAMS+1] = gp:getName()
        end
        local SAMController = Group.getController(gp)
        SAMController:setOption(AI.Option.Ground.id.ALARM_STATE,1)
      end
    end
  end
  offRedSAMS = redSAMS
  env.info("All SAMS disabled")
end

local function enableAllSAMRadars()
  for i, gp in pairs(coalition.getGroups(1), 2) do
    for index, data in pairs(gp:getUnits()) do
      if data:hasAttribute("SAM SR") then
        local isInGroup = 0
        for j = 1, #redSAMS do
          if redSAMS[j] == gp:getName() then
            isInGroup = 1       
          end
        end
        if isInGroup == 0 then      
          redSAMS[#redSAMS+1] = gp:getName()
        end
        local SAMController = Group.getController(gp)
        SAMController:setOption(AI.Option.Ground.id.ALARM_STATE,2)
      end
    end
  end
  onRedSAMS = redSAMS
  env.info("All SAMS enabled")
end

local function detectedUnits()
  detectedUnits = {}
  for i=1, #redEWR do
    local EWRGroup = Group.getByName(redEWR[i])
    local EWRController = Group.getController(EWRGroup)
    if EWRController == nil then
      return timer.getTime()+10
    end
    local detectedTargets = EWRController:getDetectedTargets()
    for j = 1, #detectedTargets do
      if detectedTargets[j].object:getCoalition() == 2 then
        detectedUnits[#detectedUnits+1] = detectedTargets[j].object:getName()
        local volSAMSearch =
          {
            id = world.VolumeType.SPHERE,
            params =
            {
              point = detectedTargets[j].object:getPoint(),
              radius = 100000
            }
          }
        --        env.info("Search volume defined")
        world.searchObjects(Object.Category.UNIT, volSAMSearch, ifFoundCloseSAM, detectedTargets[j].object)        
        env.info("Search Completed")
      end
    end
  end
  --  env.info("Running again in 10s")
  return timer.getTime()+10
end

local function noMoreEWR()
  local EWRRemaining = 0  
  for i, gp in pairs(coalition.getGroups(1), 2) do
    --    env.info("Got Red group ID:  ".. gp:getName().. " of type Ground")
    for index, data in pairs(gp:getUnits()) do
      if data:hasAttribute("EWR") then
        EWRRemaining = 1
      end
    end
  end
  if EWRRemaining == 0 then

    env.info("All EWR down, enabling all SAMs")
    enableAllSAMRadars()

  end
  return timer.getTime()+120
end

local function visualDetection()
  --  env.info("Checking visual range")
  --  env.info("Number of Red SAM groups: ".. #redSAMS)
  for i = 1, #redSAMS do
    local SAMGroup = Group.getByName(redSAMS[i])
    --    env.info("Got Group")
    local SAMController = SAMGroup:getController()
    --    env.info("Got Controller")
    local volVisSearch =
      {
        id = world.VolumeType.SPHERE,
        params =
        {
          point = SAMGroup:getUnit(1):getPoint(),
          radius = 7000
        }
      }
    env.info("Search volume defined")
    world.searchObjects(Object.Category.UNIT, volVisSearch, ifFoundVisual, SAMGroup)        
    --    env.info("Search Completed")
  end
  return timer.getTime()+20
end

timer.scheduleFunction(disableAllSAMRadars,{},timer.getTime()+5)
timer.scheduleFunction(PopulateEWRList, {}, timer.getTime()+10)
timer.scheduleFunction(populateSAMList, {}, timer.getTime()+15)
timer.scheduleFunction(detectedUnits, {}, timer.getTime()+20)
timer.scheduleFunction(visualDetection, {}, timer.getTime()+25)
timer.scheduleFunction(noMoreEWR, {}, timer.getTime()+1200)


