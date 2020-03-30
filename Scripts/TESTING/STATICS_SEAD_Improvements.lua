local tracked_weapons = {}
shotHandler = {}
local function getDistance (point1, point2)

  env.info("SEAD Script: Calculating Distance")
  local x1 = point1.x
  local y1 = point1.y
  local z1 = point1.z
  local x2 = point2.x
  local y2 = point2.y
  local z2= point2.z

  local dX = math.abs(x1-x2)
  local dZ = math.abs(z1-z2)
  local distance = math.sqrt(dX*dX + dZ*dZ)

  return distance

end
local function recoverSuppresionMag(suppUnit)

  suppUnit:getGroup():getController():setOnOff(true)
  --suppUnit:GetGroup():setOption(9, 2) --radar on  
  env.info("SEAD SCRIPT: Unit " ..suppUnit:getName().. " has turned radar back on", false)

end
local function startSuppressionMag(suppUnit)

  suppUnit:getGroup():getController():setOnOff(false)
  --  suppUnit:GetGroup():setOption(9, 1) --radar off  
  env.info("SEAD SCRIPT Unit ".. suppUnit:getID().. " has turned radar off")
  timer.scheduleFunction(recoverSuppresionMag, suppUnit, timer.getTime() + math.random(60,90))

end
local function recoverSuppresion(suppUnit, time)
  suppUnit:getController():setOnOff(true)
  env.info("SEAD SCRIPT: Unit " ..suppUnit:getName().. "has recovered from suppression.", false)
  return nil
end
local function ifFoundMag(foundItem, val)

  env.info("SEAD SCRIPT: Search found groupID: " ..foundItem:getName())
  coalition = foundItem:getCoalition()
  env.info("SEAD SCRIPT: It is part of Coalition " ..coalition)

  if coalition == 2 then
  env.info("SEAD SCRIPT: Group is friendly - Ignored")

  else 
    env.info("SEAD SCRIPT: Group is not friendly - Continue")

    if foundItem:hasAttribute("SAM SR") then

      env.info("SEAD SCRIPT: " ..foundItem:getName().. " is a SAM SR")              
      if math.random(1,100) > 30 then

        env.info("SEAD SCRIPT: Turning off Radar "..foundItem:getName()) 
        timer.scheduleFunction(startSuppressionMag, foundItem, timer.getTime() + math.random(15,30))

      end   
    end 
  end      
end
local function ifFoundK(foundItem, impactPoint)
  env.info("SEAD SCRIPT: Found unit to kill in radius")
  local groupFound = foundItem:getGroup()
  if groupFound:getCategory() == 2 then
    local point1 = foundItem:getPoint()
    point1.y = point1.y + 2
    local point2 = impactPoint
    point2.y = point2.y + 2
    if land.isVisible(point1, point2) == true then
      env.info("SEAD SCRIPT: killed")
      trigger.action.explosion(point1, 1)

    end
  end                                                                    
end
local function ifFoundKS(foundItem, impactPoint)
  env.info("SEAD SCRIPT: Found static to kill in radius")
  local point1 = foundItem:getPoint()
  env.info("SEAD SCRIPT: found static pos")
  point1.y = point1.y + 2
  local point2 = impactPoint
  point2.y = point2.y + 2
  if land.isVisible(point1, point2) == true then
    trigger.action.explosion(point1, 10)
    env.info("SEAD SCRIPT: killed")
    

  end

end
local function ifFoundS(foundItem, impactPoint)
  env.info("SEAD SCRIPT: Found unit to suppress in radius")
  local groupFound = foundItem:getGroup()
  if groupFound:getCategory() == 2 then
    local point1 = foundItem:getPoint()
    point1.y = point1.y + 2
    local point2 = impactPoint
    point2.y = point2.y + 2
    if land.isVisible(point1, point2) == true then
      foundItem:getGroup():getController():setOnOff(false)
      timer.scheduleFunction(recoverSuppresion, foundItem, time + math.random(35,120))
       env.info("SEAD SCRIPT: suppressed")
      

    end
  end                                                                    
end

function shotHandler:onEvent(event)
  if event.id == world.event.S_EVENT_SHOT 
  then
    if event.weapon then

      env.info("SEAD SCRIPT: weapon launched")          
      local ordnance = event.weapon                  
      local ordnanceName = ordnance:getTypeName()
      local WeaponPos = ordnance:getPosition().p
      local WeaponDir = ordnance:getPosition().x  
      local init = event.initiator
      local init_name = ' '
      if ordnanceName == "weapons.missiles.AGM_122" or ordnanceName == "weapons.missiles.AGM_88" or ordnanceName == "weapons.missiles.LD-10" then
        env.info("SEAD SCRIPT: of type ARM") 
        local time = timer.getTime()               
        local VolMag =
          {
            id = world.VolumeType.SPHERE,
            params =
            {
              point = ordnance:getPosition().p,
              radius = 50000
            }
          }
        env.info("SEAD SCRIPT: Begin Search for all magnum changes")
        world.searchObjects(Object.Category.UNIT, VolMag, ifFoundMag) 
        env.info("SEAD SCRIPT: Finished Search for all magnum changes")  
      end
      if init:isExist() then
        init_name = init:getName()
      end               
      tracked_weapons[event.weapon.id_] = { wpn = ordnance, init = init_name, pos = WeaponPos, dir = WeaponDir }                                         
    end

  end
end

world.addEventHandler(shotHandler)

local function track_wpns(timeInterval, time)
  for wpn_id_, wpnData in pairs(tracked_weapons) do

    if wpnData.wpn:isExist() then  -- just update position and direction.
      wpnData.pos = wpnData.wpn:getPosition().p
      wpnData.dir = wpnData.wpn:getPosition().x
      wpnData.exMass = wpnData.wpn:getDesc().warhead.explosiveMass
    else -- wpn no longer exists, must be dead.
      env.info("SEAD SCRIPT: Mass of weapon warhead is " .. wpnData.exMass)
      local suppressionRadius = wpnData.exMass
      local ip = land.getIP(wpnData.pos, wpnData.dir, 20)  -- terrain intersection point with weapon's nose.  Only search out 20 meters though.
      local impactPoint
      if not ip then -- use last position
        impactPoint = wpnData.pos
        --                    trigger.action.outText("Impact Point:\nPos X: " .. impactPoint.x .. "\nPos Z: " .. impactPoint.z, 2)

      else -- use intersection point
        impactPoint = ip
        --                    trigger.action.outText("Impact Point:\nPos X: " .. impactPoint.x .. "\nPos Z: " .. impactPoint.z, 2)

      end 

      local VolKS =
        {
          id = world.VolumeType.SPHERE,
          params =
          {
            point = impactPoint,
            radius = wpnData.exMass*0.15
          }
        }
      local VolS =
        {
          id = world.VolumeType.SPHERE,
          params =
          {
            point = impactPoint,
            radius = wpnData.exMass
          }
        }                                                                    
      local VolK =
        {
          id = world.VolumeType.SPHERE,
          params =
          {
            point = impactPoint,
            radius = wpnData.exMass*0.25
          }
        }


      env.warning("SEAD SCRIPT: Begin Search", false)
      world.searchObjects(Object.Category.UNIT, VolK, ifFoundK,impactPoint)
      world.searchObjects(Object.Category.UNIT, VolS, ifFoundS,impactPoint)
      world.searchObjects(Object.Category.STATIC, VolKS, ifFoundKS,impactPoint)       

      tracked_weapons[wpn_id_] = nil -- remove from tracked weapons first.         

    end
  end
  return time + timeInterval
end

timer.scheduleFunction(track_wpns, .5, timer.getTime() + 1)

