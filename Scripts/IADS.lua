local SAMRangeLookupTable = {

    ["Kub 1S91 str"] = 52000,

    ["S-300PS 40B6M tr"] =  100000,  

    ["Osa 9A33 ln"] = 25000,

    ["snr s-125 tr"] = 60000,  

    ["SNR_75V"] = 65000,

    ["Dog Ear radar"] = 26000,

    ["SA-11 Buk LN 9A310M1"] = 43000,

    ["Hawk tr"] = 60000,
    
    ["Tor 9A331"] = 16000

}

local SAMSite = {}
local EWRSite = {}
local AEWAircraft = {}
local suppressedGroups = {}
local tracked_weapons = {}
SEADHandler = {}

local function TableConcat(t1,t2)
  for i=1,#t2 do
    t1[#t1+1] = t2[i]
  end
  return t1
end

local function tablelength(T)
  if T == nil then

    return 0

  end
  local count = 0
  for _ in pairs(T) do 

    count = count + 1         
  end
  return count
end

local function getDistance(point1, point2)

  local x1 = point1.x
  local y1 = point1.y
  local z1 = point1.z
  local x2 = point2.x
  local y2 = point2.y
  local z2 = point2.z
  local dX = math.abs(x1-x2)
  local dY = math.abs(y1-y2)
  local dZ = math.abs(z1-z2)
  local distance = math.sqrt(dX*dX + dZ*dZ)

  return distance

end

local function getDistance3D(point1, point2)

  local x1 = point1.x
  local y1 = point1.y
  local z1 = point1.z
  local x2 = point2.x
  local y2 = point2.y
  local z2 = point2.z

  local dX = math.abs(x1-x2)
  local dY = math.abs(y1-y2)
  local dZ = math.abs(z1-z2)
  local distance = math.sqrt(dX*dX + dZ*dZ + dY*dY)

  return distance

end

local function rangeOfSAM(SAMTRName)  

  if SAMRangeLookupTable[SAMTRName] then

    return SAMRangeLookupTable[SAMTRName]

  end   
end

local function disableSAM(disableArray)
  if disableArray[3] then
--    --env.info("Emergency shutdown!")
    if SAMSite[disableArray[1]] then
    
      SAMSite[disableArray[1]].DisableTime = disableArray[2]
      SAMSite[disableArray[1]].EnableTime = nil
      SAMSite[disableArray[1]].Emitting = false
      SAMSite[disableArray[1]].SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
      if disableArray[2] then
      
--        --env.info("SAM Site: "..SAMSite[disableArray[1]].Name.." disabled for "..disableArray[2].." seconds")
            
      else
      
--        --env.info("SAM Site: "..SAMSite[disableArray[1]].Name.." disabled until instructed otherwise")
              
      end
    end
  else   
--    --env.info("Non-emergency shutdown")
--    --env.info(SAMSite[disableArray[1]].SAMGroup:getName().." is in the disable fcn")
    local detectedTargets = SAMSite[disableArray[1]].SAMGroup:getController():getDetectedTargets()
--    --env.info("It has detected "..#detectedTargets.." units and will stay on")
    if disableArray[2] == nil then
 --     --env.info("Disabling with no disable time")
      SAMSite[disableArray[1]].DisableTime = nil
      SAMSite[disableArray[1]].EnableTime = nil
      SAMSite[disableArray[1]].Emitting = false
      SAMSite[disableArray[1]].SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
--      --env.info("SAM Site: "..SAMSite[disableArray[1]].Name.." disabled until further notice")    

    elseif (disableArray[2] > SAMSite[disableArray[1]].DisableTime) then
--      --env.info("Disabling with disable time")
      SAMSite[disableArray[1]].DisableTime = disableArray[2]
      SAMSite[disableArray[1]].EnableTime = nil
      SAMSite[disableArray[1]].Emitting = false
      SAMSite[disableArray[1]].SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
--      --env.info("SAM Site: "..SAMSite[disableArray[1]].Name.." disabled for "..disableArray[2].." seconds")    

    end
  end
end

local function enableSAM(enableArray)

  if SAMSite[enableArray[1]] and SAMSite[enableArray[1]].Hidden == false then
  
    SAMSite[enableArray[1]].Emitting = true
    SAMSite[enableArray[1]].EnableTime = enableArray[2]
    SAMSite[enableArray[1]].SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,2)
    if enableArray[2] then
    
--      --env.info("SAM Site: "..SAMSite[enableArray[1]].Name.." enabled for: " ..enableArray[2].."s")
         
    else
    
--     --env.info("SAM Site: "..SAMSite[enableArray[1]].Name.." enabled until further notice")
      
    end

  end
end

local function disableAllSAMs()

  for i, SAM in pairs(SAMSite) do
    local disableArray = {SAM.Name, nil, nil} 
    disableSAM(disableArray)

  end
end

local function enableUncontrolledSAMs()
  local count = 0
  for i, SAM in pairs(SAMSite) do

    if tablelength(SAM.ControlledBy) == 0 then
      local enableArray = {SAM.Name, nil}
      enableSAM(enableArray)
      count = count + 1
    end
  end
end

local function associateSAMS()

  for i, EWR in pairs(EWRSite) do
  EWR.SAMsControlled = {}
    for j, SAM in pairs(SAMSite) do
  
      if getDistance3D(SAM.Location, EWR.Location) < 80000 then
        
        EWR.SAMsControlled[SAM.Name] = SAM
        SAM.ControlledBy[EWR.Name] = EWR
        
      end
    end
  end   
end

local function populateLists()
  SAMSite = {}
  EWRSite = {}
  AEWAircraft = {}
  local isEWR = 0
  local isSAM = 0
  local samType
  for i, gp in pairs(coalition.getGroups(1)) do

    if gp:getCategory() == 2 then

      for j, unt in pairs(gp:getUnits()) do

        if unt:hasAttribute("EWR") then

          isEWR = 1

        elseif unt:hasAttribute("SAM TR") then

          isSAM = 1
          samType = unt:getTypeName()

        end

      end
      if isEWR == 1 then
        EWRSite[gp:getName()] = {

            ["Name"] = gp:getName(),
            ["EWRGroup"] = gp,
            ["SAMsControlled"] = {},
            ["DetectedUnits"] = {},
            ["Location"] = gp:getUnit(1):getPoint()

        }
--       --env.info("EWR Registered, named: "..gp:getName())
        isEWR = 0  
        isSAM = 0

      elseif isSAM == 1 and rangeOfSAM(samType) then

        SAMSite[gp:getName()] = {

            ["Name"] = gp:getName(),
            ["SAMGroup"] = gp,
            ["Type"] = samType,
            ["Location"] = gp:getUnit(1):getPoint(),
            ["EngageRange"] = rangeOfSAM(samType),           
            ["ControlledBy"] = {}, 
            ["SuppressedTime"] = 0,
            ["Suppressed"] = false,
            ["Hidden"] = false,
            ["HiddenTime"] = 0,
            ["HideCountdown"] = 0,
            ["HideCountdownBool"] = false,
            ["EnableTime"] = 0,
            ["DisableTime"] = 0,
            ["SearchVolume"] =
            {
              id = world.VolumeType.SPHERE,
              params =
              {
                point =  gp:getUnit(1):getPoint(),
                raidus = rangeOfSAM(samType)
              }
            }
        }
        isEWR = 0  
        isSAM = 0

      end 
    end  
  end
  associateSAMS()
  --env.info("Lists Populated, there are "..tablelength(EWRSite).." EWR Sites, "..tablelength(SAMSite).." SAM Sites, and "..tablelength(AEWAircraft).." AEW Aircraft. SAM sites associated with IADS network.")
  return timer.getTime() + 600
end

local function suppress(suppArray)
  
  suppressedGroups[suppArray[1]:getName()] = {["SuppGroup"] = suppArray[1], ["SuppTime"] = suppArray[2]}
  suppArray[1]:getController():setOnOff(false)

end

local function unSuppress(unSuppGroup)
  
--  --env.info("Removing suppressed unit from group")
  unSuppGroup:getController():setOnOff(true)
  suppressedGroups[unSuppGroup:getName()] = nil
--  --env.info("Suppressed unit removed from group")

end

local function ifFoundK(foundItem, impactPoint)
--  --env.info("Found unit in kill range")
  local point1 = foundItem:getPoint()
  point1.y = point1.y + 2
  local point2 = impactPoint
  point2.y = point2.y + 2
  if land.isVisible(point1, point2) == true then
    trigger.action.explosion(point1, 1)
--    --env.info("Unit"..foundItem.getID().. "Destroyed by script")                         
  end                                                                    
end

local function ifFoundD(foundItem, impactPoint)
  env.info("Found static in kill range")
	  local point1 = foundItem:getPoint()
	  point1.y = point1.y + 2
	  local point2 = impactPoint
	  point2.y = point2.y + 2
	  if land.isVisible(point1, point2) == true then
		trigger.action.explosion(point1, 10)
	--    --env.info("Unit"..foundItem.getID().. "Destroyed by script")                         
	  end
end

local function ifFoundS(foundItem, impactPoint)
  if foundItem:getGroup() and foundItem:getName() and foundItem:getGroup():getCategory() == 2 then
--   --env.info("Suppresing: "..foundItem:getName())
    local point1 = foundItem:getPoint()
    point1.y = point1.y + 5
    local point2 = impactPoint
    point2.y = point2.y + 5
    if land.isVisible(point1, point2) == true then
      local suppTimer = math.random(35,100)
      local suppArray = {foundItem:getGroup(), suppTimer}
      suppress(suppArray)
 --     --env.info("Suppressing.")
    
    end
  end
end

local function magnumHide(hiddenGroup)

  SAMSite[hiddenGroup:getName()].HideCountdownBool = true
  SAMSite[hiddenGroup:getName()].HideCountdown = math.random(15,25)
--  --env.info("Magnum Hide "..hiddenGroup:getName())  
  
end

local function track_wpns()
  for wpn_id_, wpnData in pairs(tracked_weapons) do

    if wpnData.wpn:isExist() then  -- just update position and direction.
      wpnData.pos = wpnData.wpn:getPosition().p
      wpnData.dir = wpnData.wpn:getPosition().x
      wpnData.exMass = wpnData.wpn:getDesc().warhead.explosiveMass
    else -- wpn no longer exists, must be dead.
      --env.info("Mass of weapon warhead is " .. wpnData.exMass)
      local suppressionRadius = wpnData.exMass
      local ip = land.getIP(wpnData.pos, wpnData.dir, 20)  -- terrain intersection point with weapon's nose.  Only search out 20 meters though.
      local impactPoint
      if not ip then -- use last position
        impactPoint = wpnData.pos
       -- trigger.action.outText("Impact Point:\nPos X: " .. impactPoint.x .. "\nPos Z: " .. impactPoint.z, 2)
      else -- use intersection point
        impactPoint = ip
       -- trigger.action.outText("Impact Point:\nPos X: " .. impactPoint.x .. "\nPos Z: " .. impactPoint.z, 2)
      end 
      local VolK =
        {
          id = world.VolumeType.SPHERE,
          params =
          {
            point = impactPoint,
            radius = suppressionRadius*0.2
          }
        }
	   local VolD =
        {
          id = world.VolumeType.SPHERE,
          params =
          {
            point = impactPoint,
            radius = suppressionRadius*0.1
          }
        }
      local VolS =
        {
          id = world.VolumeType.SPHERE,
          params =
          {
            point = impactPoint,
            radius = suppressionRadius
          }
        }                              
--      env.warning("Begin Search")
      world.searchObjects(Object.Category.UNIT, VolK, ifFoundK,impactPoint)
	  world.searchObjects(Object.Category.STATIC, VolD, ifFoundD,impactPoint)
      world.searchObjects(Object.Category.UNIT, VolS, ifFoundS,impactPoint)               
--      env.warning("Finished Search")
      tracked_weapons[wpn_id_] = nil -- remove from tracked weapons first.         
    end
  end
  return timer.getTime() + .5
end

function SEADHandler:onEvent(event)
  if event.id == world.event.S_EVENT_DEAD then
  --env.info("Something died")
  if event.initiator:getCategory() ~= Object.Category.Unit and event.initiator:getGroup() then  
    local eventGroup = event.initiator:getGroup()
    for i, SAM in pairs(SAMSite) do    
      if eventGroup:getName() == SAM.Name then
        if SAM.SAMGroup == nil then
            --env.info("It is a SAM with no radars left")
            SAMSite[SAM.Name] = nil
            --env.info("Removed from list")
            associateSAMS()       
        end
      end
    end 
    for i, EWR in pairs(EWRSite) do    
      if eventGroup:getName() == EWR.Name then
        if EWR.EWRGroup == nil then      
          --env.info("It was an EWR with no group left")
          EWRSite[EWR.Name] = nil
          --env.info("Removed from list")          
          for j, SAM in pairs(SAMSite) do
            SAM.ControlledBy[eventGroup:getName()] = nil 
          end
        end
      associateSAMS()    
      enableUncontrolledSAMs()
      end
    end   
  end  
  elseif event.id == world.event.S_EVENT_SHOT then
	--env.info("Something has been launched")
    if event.weapon then
      local ordnance = event.weapon                  
      local ordnanceName = ordnance:getTypeName()
      local WeaponPoint = ordnance:getPoint()
      local init = event.initiator
      if ordnanceName == "weapons.missiles.AGM_122" or ordnanceName == "weapons.missiles.AGM_88" or ordnanceName == "weapons.missiles.LD-10" or ordnanceName == "weapons.missiles.X_58" or ordnanceName == "weapons.missiles.X_25MP" then
        for i, SAM in pairs(SAMSite) do        
          if math.random(1,100) > 10 and getDistance(SAM.Location, WeaponPoint) < 65000 then      
--            --env.info("Oh shit turn the radars off, said Ahmed, working at "..SAM.Name) 
            magnumHide(SAM.SAMGroup)
          end     
        end
      end
      tracked_weapons[event.weapon.id_] = { wpn = ordnance, init = init:getName(), pos = WeaponPoint,}                                                          
    end
  end
end


local function IADSMonitor()
  --env.info("IADS Start")
  -- CHECK SUPPRESSION
  for i, suppGroup in pairs(suppressedGroups)  do 
    if suppGroup.SuppTime and suppGroup.SuppGroup then
      if suppGroup.SuppTime < 1 then      
        unSuppress(suppGroup.SuppGroup)      
      else     
        suppGroup.SuppTime = suppGroup.SuppTime - 1  
      end
    end 
  end  
  for i, SAM in pairs(SAMSite) do
    if SAM.SAMGroup:isExist()  then     
      if SAM.HideCountdownBool then 
        if SAM.HideCountdown < 1 then          
          local disableArray = {SAM.Name, nil, true}
          SAM.HideCountdownBool = false
          SAM.Hidden = true
          SAM.HiddenTime = math.random(65,100)
          disableSAM(disableArray)        
        else        
          SAM.HideCountdown = SAM.HideCountdown - 1         
        end      
      elseif SAM.Hidden then    
        if SAM.HiddenTime < 1 then        
          local enableArray = {SAM.Name, 120}
          SAM.Hidden = false
          enableSAM(enableArray)        
        else       
          SAM.HiddenTime = SAM.HiddenTime - 1
        end   
      end  
      if SAM.EnableTime and SAM.EnableTime < 1 and SAM.Hidden == false and SAM.Emitting then        
        local disableArray = {SAM.Name, nil, nil} 
        disableSAM(disableArray)      
      elseif SAM.EnableTime and SAM.Emitting then      
        SAM.EnableTime = SAM.EnableTime - 1 
      end      
      if SAM.DisableTime and SAM.DisableTime < 1 and SAM.Emitting == false then      
        local enableArray = {SAM.Name, 120}
        enableSAM(enableArray)     
      elseif SAM.DisableTime and SAM.Emitting == false then      
        SAM.DisableTime = SAM.DisableTime - 1         
      end      
    end
   end
  -- DETECT UNITS and ACTIVATE
  for i, EWR in pairs(EWRSite) do
    if EWR.EWRGroup:isExist() then
      EWR.DetectedUnits = {}
      if EWR.EWRGroup:getController() then
        EWR.DetectedUnits = EWR.EWRGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
        for j, detectedTarget in pairs(EWR.DetectedUnits) do
          if detectedTarget.object and (detectedTarget.object:getCategory() == 1) and detectedTarget.object:getGroup() and detectedTarget.object:getGroup():getUnit(1):getPoint() and detectedTarget.object:getGroup():getUnit(1) and detectedTarget.object:inAir() then
            for k, SAM in pairs(EWR.SAMsControlled) do
              local rangeToSAM = getDistance(detectedTarget.object:getPoint(),SAM.Location)
              if rangeToSAM < SAM.EngageRange then 
                local enableArray = {SAM.Name, 180}
                enableSAM(enableArray)              
              end
            end 
          end
        end  
      end 
    end  
  end     
  --env.info("IADS Monitor complete")
  return timer.getTime() + 1
end

populateLists()
timer.scheduleFunction(track_wpns, {}, timer.getTime() + 1)
--env.info("Populated SAM, AEW and EWR lists")
disableAllSAMs()
enableUncontrolledSAMs()
--env.info("Uncontrolled SAMs enabled")
--env.info("Weapon tracking begun")
timer.scheduleFunction(IADSMonitor,{},timer.getTime()+1)
--env.info("IADS monitoring begun")
world.addEventHandler(SEADHandler)
--env.info("SEAD event handler initiated")