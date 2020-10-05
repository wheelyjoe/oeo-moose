local SAMRangeLookupTable = { -- Ranges at which SAM sites are considered close enough to activate

    ["Kub 1S91 str"] = 52000,
    ["S-300PS 40B6M tr"] =  100000,  
    ["Osa 9A33 ln"] = 25000,
    ["snr s-125 tr"] = 60000,
    ["SNR_75V"] = 65000,
    ["Dog Ear radar"] = 26000,
    ["SA-11 Buk LN 9A310M1"] = 43000,
    ["Hawk tr"] = 60000,    
    ["Tor 9A331"] = 50000,
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
local AEWAircraft = {}

IADSHandler = {}

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
     return
  else
    site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
    site.Enabled = 0
--    env.info(site.Name.." disabled")
  end
end

local function hideSAM(site) 
  site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
--  env.info(site.Name.." hidden, type: "..site.Type)
  site.Enabled = 0
end

local function enableSAM(site)
  if site.Hidden == 0 then
    site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,2)
--    env.info(site.Name.." turned on")
    site.Enabled = 1
  end
end

local function disableAllSAMs()
  for i, SAM in pairs(SAMSites) do
    disableSAM(SAM)
  end
end

local function BlinkSAM()
  for i, SAM in pairs(SAMSites) do 
--    env.info("Blinck for SAM: "..SAM.Name) 
    if tablelength(SAM.ControlledBy) < 1 then
--      env.info("SAM is uncontrolled")    
      if SAM.BlinkTimer < 1  and SAM.Hidden == 0 then  
--        env.info("Blink timer is out")       
        if SAM.Enabled == 1 then 
          disableSAM(SAM)
          SAM.BlinkTimer = math.random(150,300)
--          env.info("enabled > disabled")                
        else          
          enableSAM(SAM)
          SAM.BlinkTimer = math.random(45,85)
 --         env.info("disabled > enabled")
        end            
      else      
      SAM.BlinkTimer = SAM.BlinkTimer - 10  
--      env.info("Blink Timer countdown: "..SAM.BlinkTimer)    
      end    
    end  
  end
end

local function associateSAMS()  
  for j, SAM in pairs(SAMSites) do  
    SAM.ControlledBy = {}
  end
  for i, EWR in pairs(EWRSites) do
  EWR.SAMsControlled = {}
    for j, SAM in pairs(SAMSites) do
      if getDistance3D(SAM.Location, EWR.Location) < EWRAssociationRange then        
        EWR.SAMsControlled[SAM.Name] = SAM
        SAM.ControlledBy[EWR.Name] = EWR
      end
    end
  end
end

local function populateLists()
  SAMSites = {}
  EWRSites = {}
  AEWAircraft = {}
  local isEWR = 0
  local isSAM = 0
  local samType
  local numSAMRadars = 0
  local numTrackRadars = 0
  local numEWRRadars = 0
  for i, gp in pairs(coalition.getGroups(1)) do
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
            ["DetectedUnits"] = {},
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
            ["HiddenTime"] = 0,
            ["Hidden"] = 0,
            ["BlinkTimer"] = 0,
            ["hostileARMDetected"] = {},
            ["SearchVolume"] =
            {
              id = world.VolumeType.SPHERE,
              params =
              {
                point =  gp:getUnit(1):getPoint(),
                raidus = rangeOfSAM(gp)
              }
            },
        }
--        env.info("SAM of type: " ..samType..", range: "..rangeOfSAM(gp).." registered")
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
--  env.info("In magnumHide with SAM type: "..site.Type)
  if site.Type == "Tor 9A331" then  
--    env.info("TORs don't shut down")    
  elseif site.Hidden ~= 1 then
    local randomTime = math.random(15,35)
    timer.scheduleFunction(hideSAM, site, timer.getTime() + randomTime)
    site.HiddenTime = math.random(65,100)+randomTime
    site.Hidden = 1
--    env.info("magnumHide end")
  end
end

local function EWRdetections()
  for i, EWR in pairs(EWRSites) do
--    env.info("EWRDetections for : " ..EWR.Name)
    EWR.DetectedUnits = {}
    EWR.hostileAirDetected = {}
    if EWR.EWRGroup:getController() then
--      env.info("Got controller")
      EWR.DetectedUnits = EWR.EWRGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
--      env.info("Unit detection complete")
      if tablelength(EWR.DetectedUnits) > 0 then
--       env.info("There are: "..tablelength(EWR.DetectedUnits).." units detected")
        for j, contact in pairs(EWR.DetectedUnits) do
          if contact.object then
--            env.info("For unit: ")
--            env.info(contact.object:getName())   
            if (contact.object:getCategory() == 1) and contact.object:inAir() and contact.object:getCoalition() == 2 then  
--              env.info("Is hostile air threat")      
              EWR.hostileAirDetected[contact.object:getName()] = contact      
--              env.info("added to list")      
            elseif contact.object:getCategory() == 2 and contact.object:getCoalition() == 2 and contact.object:getDesc().guidance == 5  and IADSEWRARMDetection == 1  then
              local prevDetected = 0           
--              env.info("Hostile ARM detected by EWR")
--              env.info("EWR has detected: "..tablelength(EWR.hostileARMDetected).." hostile ARMS")
              if tablelength(EWR.hostileARMDetected) > 0 then            
--                env.info("EWR.hostileARMDetected exists")
                for k, ARM in pairs(EWR.hostileARMDetected) do
                  if (ARM.object and ARM.object:isExist()) then
--                    env.info("For previously detected ARM: ")
--                    env.info(ARM.object:getName())
                    if  ARM.object:getName() == contact.object:getName() then                  
--                      env.info("ARM is same as existing contact")
                      prevDetected = 1                  
                    else                
--                      env.info("ARM is not same")
                    end
                  else                
                    EWR.hostileARMDetected[k] = nil               
--                    env.info("ARM no longer exists, removed from list :" ..k)             
                  end                             
                end               
              else              
--                env.info("EWR.hostileARMDetected doesn't exist, adding first entry")
                EWR.hostileARMDetected[contact.object:getName()] = contact
--                env.info("Entry added")            
              end
              if prevDetected == 0 then
--                env.info("ARM has not been previously detected by EWR")
                for l, SAM in pairs(EWR.SAMsControlled) do
                  if math.random(1,100) < EWRARMShutdownChance then
--                    env.info("hiding SAM: "..SAM.Name)              
                    magnumHide(SAM)
                  end 
                  EWR.hostileARMDetected[contact.object:getName()] = contact                           
                end            
              end                                          
            end
          end
        end
      end
    end
  end
end

local function SAMdetections()
  for i, SAM in pairs(SAMSites) do
--    env.info("SAM detections for "..SAM.Name)
    SAM.hostileAirDetected = {}
    if SAM.Enabled == 1 then
--      env.info("SAM is on")
      local UnitsDetected = SAM.SAMGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
      if tablelength(UnitsDetected) > 0 then  
--        env.info("There are " ..tablelength(UnitsDetected).." detected")          
        for j, detectedTarget in pairs(UnitsDetected) do
          if detectedTarget.object then
--            env.info("For unit: ")
--            env.info(detectedTarget.object:getName())                
            if (detectedTarget.object:getCategory() == 1) and detectedTarget.object:inAir() and detectedTarget.object:getCoalition() == 2 then           
              SAM.hostileAirDetected[detectedTarget.object:getName()] = detectedTarget 
--              env.info("Detected target is hostile air")
            elseif detectedTarget.object:getCategory() == 2 and detectedTarget.object:getCoalition() == 2 and detectedTarget.object:getDesc().guidance == 5 and SAM.Type ~= "Tor 9A331" and IADSSAMARMDetection == 1 then
              local prevDetected = 0
--              env.info("Hostile ARM detected by SAM")
--              env.info("SAM has detected: "..tablelength(SAM.hostileARMDetected).." hostile ARMS")
              if tablelength(SAM.hostileARMDetected) > 0 then            
--                env.info("SAM.hostileARMDetected exists")
                for k, ARM in pairs(SAM.hostileARMDetected) do
--                  env.info("In ARMs loop at index "..k)
                  if (ARM.object and ARM.object:isExist()) then
--                   env.info("For previously detected ARM: ")
--                   env.info(ARM.object:getName())                   
                    if  ARM.object:getName() == detectedTarget.object:getName() then                  
--                     env.info("ARM is same as existing contact")
                      prevDetected = 1                  
                    else                
--                      env.info("ARM is not same")
                    end
                   else
--                    env.info("ARM no longer exists, removing from list: ")                
                    SAM.hostileARMDetected[k] = nil
--                    env.info("Removed :" ..k)             
                  end                             
                end              
              else              
--                env.info("SAM.hostileARMDetected doesn't exist, adding first entry")
                SAM.hostileARMDetected[detectedTarget.object:getName()] = detectedTarget
--                env.info("Entry added")            
              end
              if prevDetected == 0 then
--              env.info("ARM has not been previously detected by SAM")
                  if math.random(1,100) < SAMARMShutdownChance then
--                    env.info(SAM.Name.. " shutting down")
                    magnumHide(SAM)
                  end  
                  SAM.hostileARMDetected[detectedTarget.object:getName()] = detectedTarget                           
              end            
            end
          end
        end
      end
    end
  end
end

local function EWRSAMOnRequest()
  for i, EWR in pairs(EWRSites) do
--    env.info("For EWR: "..EWR.Name)
    for j, SAM in pairs(EWR.SAMsControlled) do
--      env.info("For SAM: "..SAM.Name)
      if SAM.Enabled == 0 and (tablelength(EWR.hostileAirDetected) > 0) then
          enableSAM(SAM)            
          timer.scheduleFunction(disableSAM, SAM, timer.getTime() + math.random(300, 420))
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
--      env.info("SAM: "..SAM.Name.." is hidden, with ".. SAM.HiddenTime-10 .."s left")
      SAM.HiddenTime = SAM.HiddenTime - 10
      if SAM.HiddenTime < 1 then
--        env.info("SAM: "..SAM.Name.." no longer hidden")     
        SAM.Hidden = 0
      end
    end  
  end
end

local function IADSLoop()
  if IADSEnable == 1 then
--    env.info("IADS Loop Start")
    EWRdetections()
--    env.info("EWRDetections done")
    SAMdetections()
--    env.info("SAMDetections done")
    EWRSAMOnRequest()
--    env.info("EWRSAMOnRequest done")
    SAMCheckHidden()
--    env.info("SAMCheckHidden done") 
    BlinkSAM()
--    env.info("IADS Loop End")
    return timer.getTime() + 10  
  end
end

timer.scheduleFunction(disableAllSAMs, {}, timer.getTime()+2)
timer.scheduleFunction(populateLists, {}, timer.getTime()+1)
timer.scheduleFunction(IADSLoop, {}, timer.getTime()+10)
world.addEventHandler(IADSHandler)