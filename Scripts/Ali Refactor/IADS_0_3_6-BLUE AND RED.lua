local SAMRangeLookupTable = { -- Ranges at which SAM sites are considered close enough to activate in m
    ["Kub 1S91 str"] = 52000,
    ["S-300PS 40B6M tr"] =  100000,
    ["Osa 9A33 ln"] = 25000,
    ["snr s-125 tr"] = 60000,
    ["SNR_75V"] = 65000,
    ["Dog Ear radar"] = 26000,
    ["SA-11 Buk LN 9A310M1"] = 43000,
    ["Hawk tr"] = 60000,
    ["Tor 9A331"] = 50000,
    ["rapier_fsa_blindfire_radar"] = 6000,
    ["Patriot STR"] = 100000,
    ["Roland ADS"] = 7500,
    ["HQ-7_STR_SP"] = 10000,
}
local IADSEnable = 1 -- If true IADS script is active
local IADSRadioDetection = 0 -- 1 = radio detection of ARM launch on, 0 = radio detection of ARM launch off
local IADSEWRARMDetection = 1 -- 1 = EWR detection of ARMs on, 0 = EWR detection of ARMs off
local IADSSAMARMDetection = 1 -- 1 = SAM detectionf of ARMs on, 0 = SAM detection of ARMs off
local EWRAssociationRange = 80000 --Range of an EWR in which SAMs are controlled
local IADSARMHideRangeRadio = 120000 --Range within which ARM launches are detected via radio
local IADSARMHidePctage = 20 -- %age chance of radio detection of ARM launch causing SAM shutdown
local EWRARMShutdownChance = 25 -- %age chance EWR detection of ARM causing SAM shutdown
local SAMARMShutdownChance = 75-- %age chance SAM detection of ARM causings SAM shuttown
local SAMSites = {}
local EWRSites = {}
IADSHandler = {}

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
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

local function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+i] = t2[i]
    end
    return t1
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

local function rangeOfSAM(gp)
  local maxRange = 0
  for i, unit in pairs(gp:getUnits()) do
    if unit:hasAttribute("SAM TR") and SAMRangeLookupTable[unit:getTypeName()] then
      local samRange  = SAMRangeLookupTable[unit:getTypeName()]
      if maxRange < samRange then
        maxRange = samRange
      end
    end
  end
  return maxRange
end

local function disableSAM(site)
  if tablelength(site.hostileAirDetected) > 0 then
     return timer.getTime() + math.random(60,120)
  elseif site.Enabled == 1 then
    site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
    site.Enabled = 0
    env.info("Site: "..site.Name.." has turned off")    
  end
end

local function hideSAM(site)
  site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
  site.Enabled = 0
  trigger.action.outText("Site: "..site.Name.." has hidden", 2)  
end

local function enableSAM(site)
  if site.Hidden ~= 1 and site.Enabled == 0 then
    site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,2)
    site.Enabled = 1
    env.info("Site: "..site.Name.." has turned on")
  end
end

local function disableAllSAMs()
  env.info("Disabling all SAMs")
  for i, SAM in pairs(SAMSites) do
    SAM.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
    SAM.Enabled = 0  
    env.info("Site: "..SAM.Name.." has turned off")   
  end
end

local function associateSAMS()
  for i, EWR in pairs(EWRSites) do
    EWR.SAMsControlled = {}
    for j, SAM in pairs(SAMSites) do
      if SAM.SAMGroup:getCoalition() == EWR.EWRGroup:getCoalition() and getDistance3D(SAM.Location, EWR.Location) < EWRAssociationRange then
        EWR.SAMsControlled[SAM.Name] = SAM
        SAM.ControlledBy[EWR.Name] = EWR
      end
    end
  end
end

local function magnumHide(site)
  if site.Type == "Tor 9A331" then
  elseif site.Hidden ~= 1 then
    local randomTime = math.random(15,35)
    timer.scheduleFunction(hideSAM, site, timer.getTime() + randomTime)
    site.HiddenTime = math.random(65,100)+randomTime
    site.Hidden = 1
  end
end

local function populateLists()
  SAMSites = {}
  EWRSites = {}
  local isEWR = 0
  local isSAM = 0
  local samType
  local numSAMRadars = 0
  local numTrackRadars = 0
  local numEWRRadars = 0
  for i, gp in pairs(TableConcat(coalition.getGroups(1), coalition.getGroups(2))) do
    if gp:getCategory() == 2 then
      for j, unt in pairs(gp:getUnits()) do
        if unt:hasAttribute("EWR") then
          isEWR = 1
          numEWRRadars = numEWRRadars + 1
        elseif unt:hasAttribute("SAM TR") then
          isSAM = 1
          samType = unt:getTypeName()
          numSAMRadars = numSAMRadars + 1
        end
      end
      if isEWR == 1 then
        EWRSites[gp:getName()] = {
            ["Name"] = gp:getName(),
            ["EWRGroup"] = gp,
            ["SAMsControlled"] = {},
            ["hostileAirDetected"] = {},
            ["Location"] = gp:getUnit(1):getPoint(),
            ["numEWRRadars"] = numEWRRadars,
            ["hostileARMDetected"] = {},
        }
        isEWR = 0
        isSAM = 0
        numEWRRadars = 0
        numSAMRadars = 0
      elseif isSAM == 1 and rangeOfSAM(gp) then
        SAMSites[gp:getName()] = {
            ["Name"] = gp:getName(),
            ["SAMGroup"] = gp,
            ["Type"] = samType,
            ["Location"] = gp:getUnit(1):getPoint(),
            ["numSAMRadars"] = numSAMRadars,
            ["EngageRange"] = rangeOfSAM(gp),
            ["ControlledBy"] = {},
            ["Enabled"] = 1,
            ["Hidden"] = 0,
            ["BlinkTimer"] = 0,
            ["hostileAirDetected"] = 0,
            ["hostileARMDetected"] = {},
        }
        isEWR = 0
        isSAM = 0
        numEWRRadars = 0
        numSAMRadars = 0
      end
    end
  end
  associateSAMS()
  return timer.getTime() + 600
end

local function magnumHide(site)
  if site.Type == "Tor 9A331" then
  elseif site.Hidden ~= 1 then
    local randomTime = math.random(15,35)
    timer.scheduleFunction(hideSAM, site, timer.getTime() + randomTime)
    site.HiddenTime = math.random(65,100)+randomTime
    site.Hidden = 1
  end
end

local function EWRdetection()
  for i, EWR in pairs(EWRSites) do
    EWR.hostileAirDetected = {}
    if EWR.EWRGroup:getController() then
      local detections = EWR.EWRGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
      for j, detectObj in pairs(detections) do
        if detectObj.object and detectObj.object:getCategory() == 1 and detectObj.object:inAir() then
          EWR.hostileAirDetected[detectObj.object:getName()] = detectObj.object
        elseif detectObj.object and detectObj.object:getCategory() == 2 and detectObj.object:getDesc().guidance == 5 and IADSEWRARMDetection == 1 then
          local prevDetected = 0
          if tablelength(EWR.hostileARMDetected) > 0 then
            for k, existingARMs in pairs(EWR.hositleARMDetected) do
              if existingARMs == detectObj.object:getName() then
                prevDetected = 1
              end
            end
          end
          if prevDetected == 0 then
            for k, SAM in pairs(EWR.SAMsControlled) do
              if math.random(1,100) < EWRARMShutdownChance then
                magnumHide(SAM)
              end
            end
          end
        end
      end
    end
    env.info("EWR: "..EWR.Name.." has detected: "..table.tostring(EWR.hostileAirDetected))
  end
end

local function SAMdetection()
  for i, SAM in pairs(SAMSites) do
    SAM.hostileAirDetected = {}
    if SAM.SAMGroup:getController() then
      local detections = SAM.SAMGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
      for j, detectObj in pairs(detections) do
        if detectObj.object and detectObj.object:getCategory() == 1 and detectObj.object:inAir() then
          SAM.hostileAirDetected[detectObj.object:getName()] = detectObj.object
        elseif detectObj.object and detectObj.object:getCategory() == 2 and detectObj.object:getDesc().guidance == 5 and IADSEWRARMDetection == 1 then
          local prevDetected = 0
          if tablelength(SAM.hostileARMDetected) > 0 then
            for k, existingARMs in pairs(SAM.hositleARMDetected) do
              if existingARMs == detectObj.object:getName() then
                prevDetected = 1
              end
            end
          end
          if prevDetected == 0 and math.random(1,100) < SAMARMShutdownChance then
            magnumHide(SAM)
          end
        end
      end
    end
  end
end

local function EWRSAMComms()
  for j, SAM in pairs(SAMSites) do
    if(tablelength(SAM.ControlledBy) > 0) then
      local viableTarget = false 
      for i, EWR in pairs(SAM.ControlledBy) do
        for k, target in pairs(EWR.hostileAirDetected) do
          if getDistance(SAM.Location, target:getPoint()) < SAM.EngageRange then
            viableTarget = true
          end
        end 
      end
      if viableTarget then
        enableSAM(SAM)
      else
        disableSAM(SAM)        
      end
    end
  end
end


function IADSHandler:onEvent(event)
  if event.id == world.event.S_EVENT_SHOT and IADSRadioDetection == 1 then
    if event.weapon then
      local ordnance = event.weapon
      local WeaponPoint = ordnance:getPoint()
      local WeaponDesc = ordnance:getDesc()
      local init = event.initiator
      if WeaponDesc.guidance == 5 then
        for i, SAM in pairs(SAMSites) do
          if math.random(1,100) < IADSARMHidePctage and getDistance(SAM.Location, WeaponPoint) < IADSARMHideRangeRadio then
            magnumHide(SAM)
          end
        end
      end
    end
  elseif event.id == world.event.S_EVENT_DEAD then
  if event.initiator:getCategory() == Object.Category.UNIT and event.initiator:getGroup() then
    local eventUnit = event.initiator
    local eventGroup = event.initiator:getGroup()
    for i, SAM in pairs(SAMSites) do
      if eventGroup:getName() == SAM.Name then
        if eventUnit:hasAttribute("SAM TR") then
          SAM.numSAMRadars = SAM.numSAMRadars - 1
        end
        if SAM.numSAMRadars < 1 then
          for j, EWR in pairs(EWRSites) do
              for k, SAMControlled in pairs(EWR.SAMsControlled) do
                if SAMControlled.Name == SAM.Name then
                  SAMControlled = nil
                end
              end
          end
          SAMSites[SAM.Name] = nil
        end
      end
    end
    for i, EWR in pairs(EWRSites) do
      if eventGroup:getName() == EWR.Name then
        if eventUnit:hasAttribute("EWR") then
          EWR.numEWRRadars = EWR.numEWRRadars - 1
          if EWR.numEWRRadars < 1 then
            for j, SAM in pairs(SAMSites) do
              for k, controllingEWR in pairs(SAM.ControlledBy) do
                if controllingEWR.Name == EWR.Name then
                  controllingEWR = nil
                end
              end
            end
            EWRSites[EWR.Name] = nil
          end
        end
      end
    end
  end
 end
end

local function SAMCheckHidden()
  for i, SAM in pairs(SAMSites) do
    if SAM.Hidden == 1 then
      SAM.HiddenTime = SAM.HiddenTime - 1
      if SAM.HiddenTime < 1 then
        SAM.Hidden = 0
      end
    end
  end
end

local function BlinkSAM()
  for i, SAM in pairs(SAMSites) do
    if tablelength(SAM.ControlledBy) < 1 then
      if SAM.BlinkTimer < 1  and SAM.Hidden == 0 then
        if SAM.Enabled == 1 then
          disableSAM(SAM)
          env.info("SAM: "..SAM.Name.." blinked off")
          SAM.BlinkTimer = math.random(30,60)
        else
          enableSAM(SAM)
          env.info("SAM: "..SAM.Name.." blinked on")
          SAM.BlinkTimer = math.random(30,60)
        end
      else
      SAM.BlinkTimer = SAM.BlinkTimer - 1
      end
    end
  end
end

local function IADSLoop()
  if IADSEnable == 1 then
--    env.info("IADS Loop Start")
    EWRdetection()
--    env.info("EWRDetections done")
    SAMdetection()
--    env.info("SAMDetections done")
    EWRSAMComms()
--    env.info("EWRSAMOnRequest done")
    SAMCheckHidden()
--    env.info("SAMCheckHidden done")
    BlinkSAM()
--    env.info("IADS Loop End")
    return timer.getTime() + 1
  end
end

world.addEventHandler(IADSHandler)
timer.scheduleFunction(populateLists, {}, timer.getTime()+1)
timer.scheduleFunction(disableAllSAMs, {}, timer.getTime()+5)
timer.scheduleFunction(IADSLoop, {}, timer.getTime()+10)
