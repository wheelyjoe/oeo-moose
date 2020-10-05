--[[

10/2/2020
FrozenDroid:
- Added error handling to all event handler and scheduled functions. Lua script errors can no longer bring the server down.
- Added some extra checks to which weapons to handle, make sure they actually have a warhead (how come S-8KOM's don't have a warhead field...?)

--]]

local rwys = {["Shiraz_29L"] = {381635.21875012, -353763.65624997, 379710.53125012, -349936.71874997, 379748.90625012, -349916.78124997},
              ["Shiraz_29R"] = {382072.68750012, -353615.09374997, 380120.06250012, -349730.49999997, 380159.25000012, -349711.37499997},
              ["Kerman"] = {455913.93750012, 70361.593750032, 452335.71875012, 71777.882812532, 452351.53125012, 71820.078125032},
              ["Jiroft"] = {283647.96875012, 140328.53125003, 281615.87500012, 142902.03125003, 281656.28125012, 142934.45312503},
              ["Lar"] = {168965.60937512, -183914.85937497, 168944.06250012, -180747.65624997, 168990.84375012, -180747.62499997},
              ["Lavan"] = {76282.875000116, -288061.96874997, 75259.625000116, -285565.84374997, 75302.648437616, -285548.68749997},
              ["Kish_09R"] = {42662.160156366, -226947.57812497, 42266.792968866, -223310.96874997, 42311.531250116, -223306.20312497},
              ["Kish_09L"] = {42960.886718866, -226915.28124997, 42565.523437616, -223278.67187497, 42610.261718866, -223273.90624997},
              ["BandarLengeh"] = {41333.718750116, -142206.43749997, 41701.390625116, -139733.29687497, 41743.664062616, -139739.42187497},
              ["Havadarya"] = {109034.46093762, -7541.3710937175, 109527.10937512, -4990.66894528, 109565.15625012, -4997.6113280925},
              ["BandarAbbas_03L"] = {114361.35937512, 13242.183593782, 117412.07031262, 14864.027343782, 117427.38281262, 14835.77636722},
              ["BandarAbbas_03R"] = {114150.82812512, 13422.391601595, 117376.89062512, 15138.367187532, 117396.82812512, 15101.035156282},
              ["Jask"] = {-57802.374999884, 155200.57812503, -56700.355468634, 157240.00000003, -56672.449218634, 157225.34375003},
              ["Qeshm"] = {63430.300781366, -34986.742187468, 66141.726562616, -31754.738281218, 66172.117187616, -31780.085937468},
              ["TunbAFB"] = {9613.9453126158, -92895.992187468, 11515.284179803, -91893.742187468, 11533.810546991, -91928.015624968},
              ["TunbKochak"] = {8941.5771485533, -109903.28906247, 9069.5195313658, -109036.64062497, 9103.8310548033, -109042.98437497},
              ["SirAbuNuayr"] = {-103051.99218738, -203365.32812497, -103182.21093738, -202585.51562497, -103153.35156238, -202580.24999997},
              ["Sirri"] = {-26215.613281134, -171739.70312497, -27720.441406134, -169759.99999997, -27687.058593634, -169734.85937497},
              ["Sharjah_30R"] = {-91497.484374884, -75051.546874968, -93702.468749884, -71650.921874968, -93644.703124884, -71614.726562468},
              ["Sharjah_30L"] = {-91695.703124884, -75181.226562468, -93906.289062384, -71781.304687468, -93866.765624884, -71757.101562468},
              ["Dubai_30L"] = {-100635.14062488, -89596.789062468, -102922.54687488, -85946.999999968, -102865.88281238, -85910.179687468},
              ["Dubai_30R"] = {-99476.421874884, -90720.046874968, -101610.51562488, -87318.898437468, -101553.21874988, -87282.664062468},
              ["RasAlKhaimah"] = {-59834.652343634, -31291.902343718, -63469.371093634, -30332.253906218, -63458.890624884, -30287.337890593},
              ["Fujairah"] = {-116696.24218738, 5886.4477539387, -118143.17968738, 9344.8730469075, -118102.77343738, 9361.23339847},
              ["AlMaktoum"] = {-139019.21874988, -111910.35937497, -141400.49999988, -108093.05468747, -141342.68749988, -108058.65624997},
              ["Al Ain"] = {-209046.49999988, -65161.523437468, -213010.65624988, -65718.937499968, -213015.89062488, -65674.492187468},
              ["AbuDhabi_31R"] = {-187193.10937488, -163651.48437497, -189763.04687488, -160449.68749997, -189716.43749988, -160413.24999997},
              ["AbuDhabi_31L"] = {-189477.96874988, -164002.10937497, -192047.90624988, -160800.29687497, -192001.29687488, -160763.85937497},
              ["SasAlNakheel"] = {-188743.42187488, -176267.81249997, -190561.48437488, -175685.14062497, -190552.09374988, -175655.20312497},
              ["AlBateen"] = {-189913.35937488, -183237.12499997, -191932.60937488, -180753.87499997, -191893.95312488, -180722.95312497},
              ["Liwa"] = {-274527.84374988, -249605.95312497, -276994.68749988, -246902.84374997, -276952.43749988, -246869.64062497},
              ["Abu Musa"] = {-31678.585937384, -122810.77343747, -31375.583984259, -119836.67968747, -31330.705078009, -119841.18749997},
              ["Khasab"] = {1206.5389405455, 155.66928103835, -1485.4458006655, -516.84564205735, -1495.728027228, -472.84732052415},
              ["AlMinhad"] = {-126034.51562488, -91057.382812468, -126033.99218738, -87122.164062468, -125994.11718738, -87121.851562468},
              ["AlDhafra_31R"] = {-209913.59374988, -174704.32812497, -212164.14062488, -171817.40624997, -212127.89062488, -171786.84374997},
              ["AlDhafra_31L"] = {-211856.45312488, -174395.04687497, -214106.92187488, -171507.89062497, -214047.85937488, -171459.54687497},
              }

local weaponDamageEnable = 1
local killRangeMultiplier = 0.35
local staticDamageRangeMultiplier = 0.035
local stunRangeMultiplier = 1.0

local suppressedGroups = {}
local tracked_weapons = {}
local USearchArray = {}
WpnHandler = {}

local function getDistance(point1, point2)

  local x1 = point1.x
  local y1 = point1.y
  local z1 = point1.z
  local x2 = point2.x
  local y2 = point2.y
  local z2 = point2.z
  local dX = math.abs(x1-x2)
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

local function pointInPolygon( x, y, ...)
  local vertices = {...}
  local points= {}
  
  for i=1, #vertices-1, 2 do
    points[#points+1] = { x=vertices[i], y=vertices[i+1] }
  end
  local i, j = #points, #points
  local inside = false

  for i=1, #points do
    if ((points[i].y < y and points[j].y>=y or points[j].y< y and points[i].y>=y) and (points[i].x<=x or points[j].x<=x)) then
      if (points[i].x+(y-points[i].y)/(points[j].y-points[i].y)*(points[j].x-points[i].x)<x) then
        inside = not inside
      end
    end
    j = i
  end

  return inside
end

local function pointInRwy(x,y)

  for name, rwy in pairs(rwys) do
  
    if pointInPolygon(x, y, rwy) then
    
      trigger.action.setUserFlag(name, true)
      timer.scheduleFunction(trigger.action.setUserFlag(name, false), timer.getTime()+3600)
    
    end  
  end
end

local function suppress(suppArray)
  
  suppressedGroups[suppArray[1]:getName()] = {["SuppGroup"] = suppArray[1], ["SuppTime"] = suppArray[2]}
  if suppArray[1]:getController() then
    suppArray[1]:getController():setOnOff(false)
--  env.info("Group: "..suppArray[1]:getName().." suppressed")
  end

end

local function unSuppress(unSuppGroup)
--    env.info("In unSuppress")
    if unSuppGroup:isExist() and unSuppGroup:getController() then
      unSuppGroup:getController():setOnOff(true)
  --    env.info("Got controller")
  --    env.info("Suppressed group removed from table")
      suppressedGroups[unSuppGroup:getName()] = nil    
  end
end

local function ifFoundS(foundItem, impactPoint)
--  trigger.action.outText("Found Static", 10)
--  env.info("Found static in kill range")
  local point1 = foundItem:getPoint()
  point1.y = point1.y + 2
  local point2 = impactPoint
  point2.y = point2.y + 2
  if land.isVisible(point1, point2) == true then
--    env.info("Static"..foundItem:getID().. "Destroyed by script")                         
    trigger.action.explosion(point1, 5)
  end  
end

local function ifFoundU(foundItem, USearchArray)

--  env.info("Found Unit")
  local point1 = foundItem:getPoint()
--  env.info("Got point")
  point1.y = point1.y + 5
  local point2 = USearchArray.point
  point2.y = point2.y + 5
  if land.isVisible(point1, point2) == true then
--    env.info("is visible LOS")
    local distanceFrom = getDistance(point1, point2)  
--    env.info("got distance: "..distanceFrom)
    if distanceFrom < USearchArray.exMass*killRangeMultiplier then
      trigger.action.explosion(foundItem:getPoint(), 1)
 --     env.info("Unit: "..foundItem:getName().." was destroyed by script")    
    -- else    
    --   local suppTimer = math.random(30,100)
    --   local suppArray = {foundItem:getGroup(), suppTimer}
    --   suppress(suppArray)    
   end
  end         

end

local function track_wpns()
--  env.info("Weapon Track Start")
  for wpn_id_, wpnData in pairs(tracked_weapons) do  
  
    if wpnData.wpn:isExist() then  -- just update position and direction.
      wpnData.pos = wpnData.wpn:getPosition().p
      wpnData.dir = wpnData.wpn:getPosition().x
      wpnData.exMass = wpnData.wpn:getDesc().warhead.explosiveMass
      --wpnData.lastIP = land.getIP(wpnData.pos, wpnData.dir, 50)
    else -- wpn no longer exists, must be dead.
--      trigger.action.outText("Weapon impacted, mass of weapon warhead is " .. wpnData.exMass, 2)
      local ip = land.getIP(wpnData.pos, wpnData.dir, 20)  -- terrain intersection point with weapon's nose.  Only search out 20 meters though.
      local impactPoint
      if not ip then -- use last calculated IP
        impactPoint = wpnData.pos
--        trigger.action.outText("Impact Point:\nPos X: " .. impactPoint.x .. "\nPos Z: " .. impactPoint.z, 2)
      else -- use intersection point
        impactPoint = ip
--        trigger.action.outText("Impact Point:\nPos X: " .. impactPoint.x .. "\nPos Z: " .. impactPoint.z, 2)
      end 
      local staticRadius = wpnData.exMass*staticDamageRangeMultiplier
--     trigger.action.outText("Static Radius :"..staticRadius, 10)      
     local VolS =
        {
          id = world.VolumeType.SPHERE,
          params =
          {
            point = impactPoint,
            radius = staticRadius
          }
        }
      local VolU =
        {
          id = world.VolumeType.SPHERE,
          params =
          { 
            point = impactPoint,
            radius = wpnData.exMass*stunRangeMultiplier
          }
        }  
--      env.info("Static search radius: " ..wpnData.exMass*staticDamageRangeMultiplier)                                      
--      env.warning("Begin Search")
--      trigger.action.outText("Beginning Searches", 10)
      world.searchObjects(Object.Category.STATIC, VolS, ifFoundS,impactPoint)
      USearchArray = {["point"] = impactPoint, ["exMass"] = wpnData.exMass}
      world.searchObjects(Object.Category.UNIT, VolU, ifFoundU, USearchArray)
      pointInRwy(impactPoint.x, impactPoint.z)       
--      env.warning("Finished Search")
      tracked_weapons[wpn_id_] = nil -- remove from tracked weapons first.         
    end
  end
--  env.info("Weapon Track End")
end

local function checkSuppression()
--  env.info("Checking suppression")
  for i, group in pairs(suppressedGroups) do  
--    env.info("Check group exists, #".. i)
    if group.SuppGroup:isExist() then
--      env.info("It does")
     group.SuppTime = group.SuppTime - 10   
     if group.SuppTime < 1 then 
--      env.info("SuppTime < 1")  
      unSuppress(group.SuppGroup)       
     end  
   else  
    suppressedGroups[group.SuppGroup:getName()] = nil    
   end
  end
--  env.info("Ending suppression check")
end

function onWpnEvent(event)
  if event.id == world.event.S_EVENT_SHOT then
    if event.weapon then
      local ordnance = event.weapon
      local weapon_desc = ordnance:getDesc()
      if (weapon_desc.category == 3 or weapon_desc.category == 2 or weapon_desc.category == 1) and not (weapon_desc.missileCategory == 1 or weapon_desc.missileCategory == 2 or weapon_desc.missileCategory == 3) and weapon_desc.warhead and weapon_desc.warhead.explosiveMass and weapon_desc.type == Weapon.WarheadType.HE and event.initiator then
        tracked_weapons[event.weapon.id_] = { wpn = ordnance, init = event.initiator:getName(), pos = ordnance:getPoint(), dir = ordnance:getPosition().x, exMass = weapon_desc.warhead.explosiveMass }
--        env.info("Tracking " .. event.initiator:getName())
      end
    end
  end
end

function WpnHandler:onEvent(event)
  protectedCall(onWpnEvent, event)
end

function protectedCall(...)
  local status, retval = pcall(...)
  if not status then
--    env.info("Splash damage script error... gracefully caught! " .. retval)
  end
end

if (weaponDamageEnable == 1) then
  timer.scheduleFunction(function() 
      protectedCall(track_wpns)
      return timer.getTime() + 1
    end, 
    {}, 
    timer.getTime() + 0.5
  )

  timer.scheduleFunction(function() 
      protectedCall(checkSuppression) 
      return timer.getTime() + 1
    end, 
    {}, 
    timer.getTime() + 10
  )

  world.addEventHandler(WpnHandler)
end