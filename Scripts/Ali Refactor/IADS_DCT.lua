local Logger      = require("dct.Logger").getByName("IADS")
local Command     = require("dct.Command")
local class       = require("libs.class")

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
local IADSEnable = true -- If true IADS script is active
local IADSRadioDetection = true -- 1 = radio detection of ARM launch on, 0 = radio detection of ARM launch off
local IADSEWRARMDetection = true -- 1 = EWR detection of ARMs on, 0 = EWR detection of ARMs off
local IADSSAMARMDetection = true -- 1 = SAM detectionf of ARMs on, 0 = SAM detection of ARMs off
local EWRAssociationRange = 80000 --Range of an EWR in which SAMs are controlled
local IADSARMHideRangeRadio = 120000 --Range within which ARM launches are detected via radio
local IADSARMHidePctage = 20 -- %age chance of radio detection of ARM launch causing SAM shutdown
local EWRARMShutdownChance = 25 -- %age chance EWR detection of ARM causing SAM shutdown
local SAMARMShutdownChance = 75-- %age chance SAM detection of ARM causings SAM shuttown
local trackMemory = 20 -- Track persistance time after last detection
local controlledSAMNoAmmo = true -- Have controlled SAMs stay off if no ammo remaining.
local uncontrolledSAMNoAmmo = false -- Have uncontrolled SAMs stay off in no ammo remaining

local IADS = class()

local function tablelength(T)
  if T == nil then
    return 0
  end
  local count = 0
  for _, item in pairs(T) do
    if item~=nil then
      count = count + 1
    end
  end
  return count
end

local function getDistance(point1, point2)
  local x1 = point1.x
  local z1 = point1.z
  local x2 = point2.x
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

local function rangeOfSAM(gp)
  local maxRange = 0
  for _, unit in pairs(gp:getUnits()) do
    if unit:hasAttribute("SAM TR") and SAMRangeLookupTable[unit:getTypeName()] then
      local samRange  = SAMRangeLookupTable[unit:getTypeName()]
      if maxRange < samRange then
        maxRange = samRange
      end
    end
  end
  return maxRange
end

local function prevDetected(Sys, ARM)
  for _, prev in pairs(Sys.ARMDetected) do
    if prev:isExist() and ARM:getName() == prev:getName() then
        return true
    end
  end
end

local function trackfileBuild(target, site)
  local trackName = target.object.id_
  site.TrackFiles[trackName] = {}
  site.TrackFiles[trackName]["Name"] = trackName
  site.TrackFiles[trackName]["Object"] = target.object
  site.TrackFiles[trackName]["LastDetected"] = timer.getAbsTime()
  if target.distance then
    site.TrackFiles[trackName]["Position"] = target.object:getPosition()
    site.TrackFiles[trackName]["Velocity"] = target.object:getVelocity()
  end
  if target.type then
    site.TrackFiles[trackName]["Category"] = target.object:getCategory()
    site.TrackFiles[trackName]["Type"] = target.object:getTypeName()
  end
  if site.Datalink then
    site.TrackFiles[trackName]["Datalink"] = true
  end
end

local function hideSAM(site)
  site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
  site.Enabled = false
end

local function hasAmmo(site)
 for _, unt in pairs(site.SAMGroup:getUnits()) do
   local ammo = unt:getAmmo()
   if ammo then
     for j=1, #ammo do
        if ammo[j].count > 0 and ammo[j].desc.guidance == 3 or ammo[j].desc.guidance == 4 then
          return true
        end
      end
    end
  end
end

local function enableSAM(site)
  if (not site.Hidden) and (not site.Enabled) then
    if hasAmmo(site) then
      site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,2)
      site.Enabled = true 
      env.info("Enable SAM: "..site.Name..", range: "..site.EngageRange) 
    else 
      if tablelength(site.ControlledBy) > 0 and (not controlledSAMNoAmmo) then
        site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,2)
        site.Enabled = true
        env.info("Enable SAM: "..site.Name..", range: "..site.EngageRange) 
      elseif tablelength(site.ControlledBy) < 1 and (not uncontrolledSAMNoAmmo) then
        site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,2)
        site.Enabled = true
        env.info("Enable SAM: "..site.Name..", range: "..site.EngageRange) 
      end
    end
  end
end

local function SAMTrackInRange(SAM)
  for _, track in pairs(SAM.TrackFiles) do  
    if getDistance(SAM.Location, track.Object:getPoint()) < SAM.EngageRange then    
      return true    
    end    
  end
end

local function EWRSAMOnRequest(SAM)
  if(tablelength(SAM.ControlledBy) > 0) then
    local viableTarget = false
    for _, EWR in pairs(SAM.ControlledBy) do
      for _, target in pairs(EWR.TrackFiles) do
        if target.Position and target.Object:isExist() and target.Object:getCategory() == 1 and getDistance(SAM.Location, target.Object:getPoint()) < SAM.EngageRange then
          env.info("SAM: "..SAM.Name.." enabled due to range (EWR) to aircraft: "..getDistance(SAM.Location, target.Object:getPoint()))
          return true
        end
      end
    end
  end
end

local function disableSAM(site)
  if site.Enabled then
    site.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
    site.Enabled = false
    env.info("Disable SAM: "..site.Name)    
  end
end

function IADS:associateSAMS()
  for _, EWR in pairs(self.EWRSites) do
    EWR.SAMsControlled = {}
    for _, SAM in pairs(self.SAMSites) do
      SAM.ControlledBy = {}
      if SAM.SAMGroup:getCoalition() == EWR.EWRGroup:getCoalition() and getDistance3D(SAM.Location, EWR.Location) < EWRAssociationRange then
        EWR.SAMsControlled[SAM.Name] = SAM
        SAM.ControlledBy[EWR.Name] = EWR
      end
    end
  end
end

function IADS:magnumHide(site)
  if (not site.Hidden) and site.Type ~= "Tor 9A331" then
    local randomTime = math.random(15,35)
    self.theater:queueCommand(randomTime, Command(hideSAM, site))
    site.HiddenTime = math.random(65,100)+randomTime
    site.Hidden = true
  end
end

function IADS:EWRarmDetection(target, EWR)
  if target.object:getCategory() == 2 and target.object:getDesc().guidance == 5 and IADSEWRARMDetection and not prevDetected(EWR, target.object) then
    EWR.ARMDetected[target.object:getName()] = target.object
    for _, SAM in pairs(EWR.SAMsControlled) do
      if math.random(1,100) < EWRARMShutdownChance then
        self:magnumHide(SAM)
      end
    end
  end
end

function IADS:SAMarmDetection(target, SAM)
  if target.object:getCategory() == 2 and target.object:getDesc().guidance == 5 and IADSSAMARMDetection and not prevDetected(SAM, target.object) then
    SAM.ARMDetected[target.object:getName()] = target.object
    if math.random(1,100) < SAMARMShutdownChance then
      self:magnumHide(SAM)
    end
  end 
end

function IADS:EWRTrackFileBuild()
  for _, EWR in pairs(self.EWRSites) do
    local detections = EWR.EWRGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
    for j, target in pairs(detections) do
      if target.object and target.object:inAir() then
        self:EWRarmDetection(target, EWR)   
        trackfileBuild(target, EWR)
        self.TrackFiles["EWR"][target.object.id_] = EWR.TrackFiles[target.object.id_]
      end
    end
    for _, track in pairs(EWR.TrackFiles) do   
      if ((timer.getAbsTime() - track.LastDetected) > trackMemory or (not track.Object:isExist()) or (not track.Object:inAir())) then      
        EWR.TrackFiles[track.Name] = nil 
        self.TrackFiles.EWR[track.Name] = nil     
      end   
    end 
  end
  return 2
end

function IADS:SAMTrackFileBuild()
  for _, SAM in pairs(self.SAMSites) do
    local detections = SAM.SAMGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
    for _, target in pairs(detections) do
      if target.object and target.object:inAir() then
        self:SAMarmDetection(target, SAM)
        trackfileBuild(target, SAM)
        self.TrackFiles["SAM"][target.object.id_] = SAM.TrackFiles[target.object.id_]
      end
    end
    for _, track in pairs(SAM.TrackFiles) do    
      if ((timer.getAbsTime() - track.LastDetected) > trackMemory or (not track.Object:isExist()) or (not track.Object:inAir())) then      
        SAM.TrackFiles[track.Name] = nil
        self.TrackFiles.SAM[track.Name] = nil      
      end   
    end  
  end
  return 2
end

function IADS:AWACSTrackFileBuild()
  for _, AWACS in pairs(self.AWACSAircraft) do
    local detections = AWACS.AWACSGroup:getController():getDetectedTargets(Controller.Detection.RADAR)
    for _, target in pairs(detections) do
      if target.object and target.object:inAir() then
        trackfileBuild(target, AWACS)
        self.TrackFiles["AWACS"][target.object.id_] = AWACS.TrackFiles[target.object.id_]
      end
    end
    for _, track in pairs(AWACS.TrackFiles) do
      if ((timer.getAbsTime() - track.LastDetected) > trackMemory or (not track.Object:isExist()) or (not track.Object:inAir())) then
      AWACS.TrackFiles[track.Name] = nil 
      self.TrackFiles.AWACS[track.Name] = nil     
      end   
    end  
  end
  return 2
end

function IADS:IADSTick()
  for _, SAM in pairs(self.SAMSites) do
    if tablelength(SAM.ControlledBy) > 0 then
      if SAMTrackInRange(SAM) or self:EWRSAMOnRequest(SAM) then
        enableSAM(SAM)
      else    
        self:disableSAM(SAM)    
      end 
    end
  end
  return 2
end

function IADS:SAMCheckHidden()
  for _, SAM in pairs(self.SAMSites) do
    if SAM.Hidden then
      SAM.HiddenTime = SAM.HiddenTime - 2
      if SAM.HiddenTime < 1 then
        SAM.Hidden = false
      end
    end
  end
  return 2
end

function IADS:BlinkSAM()
  for _, SAM in pairs(self.SAMSites) do
    if tablelength(SAM.ControlledBy) < 1 then
      if SAM.BlinkTimer < 1  and (not SAM.Hidden) then
        if SAM.Enabled then
          env.info("Following is blink")        
          self:disableSAM(SAM)
          SAM.BlinkTimer = math.random(30,60)
        else
          env.info("Following is blink")
          enableSAM(SAM)
          SAM.BlinkTimer = math.random(30,60)
        end
      else
      SAM.BlinkTimer = SAM.BlinkTimer - 2
      end
    end
  end
  return 2
end

function IADS:deadSAM(SAM)
  SAM.numSAMRadars = SAM.numSAMRadars - 1
  if SAM.numSAMRadars < 1 then
    for _, controllingEWR in pairs(SAM.ControlledBy) do  
      controllingEWR.SAMsControlled[SAM.Name] = nil  
    end
    self.SAMSites[SAM.Name] = nil
  end
end

function IADS:deadEWR(EWR)
  EWR.numEWRRadars = EWR.numEWRRadars - 1
  if EWR.numEWRRadars < 1 then
    for _, controlledSAM in pairs(EWR.SAMsControlled) do
      controlledSAM.ControlledBy[EWR.Name] = nil
    end
    self.EWRSites[EWR.Name] = nil
  end
end

function IADS:deadAWACS(AWACS)
  AWACS.numAWACS = AWACS.numAWACS - 1
  if AWACS.numAWACS < 1 then
    self.AWACSAircraft[AWACS.Name] = nil 
  end          
end

function IADS:onDeath(event)
  if event.initiator:getCategory() == Object.Category.UNIT and event.initiator:getGroup() then
    local eventUnit = event.initiator  
    local eventGroup = event.initiator:getGroup()
    for _, SAM in pairs(self.SAMSites) do     
      if eventGroup:getName() == SAM.Name then
        if eventUnit:hasAttribute("SAM TR") then
          self:deadSAM(SAM)
        end
      end
    end 
    for _, EWR in pairs(self.EWRSites) do    
      if eventGroup:getName() == EWR.Name then
        if eventUnit:hasAttribute("EWR") then
          self:deadEWR(EWR)
        end
      end
      for _, AWACS in pairs(self.AWACSAircraft) do    
        if eventGroup:getName() == AWACS.Name then
          if eventUnit:hasAttribute("AWACS") then
            self:deadAWACS(AWACS)
          end
        end
      end
    end   
  end   
end

function IADS:onShot(event)
  if IADSRadioDetection and event.weapon then    
    local ordnance = event.weapon
    local WeaponPoint = ordnance:getPoint()
    local WeaponDesc = ordnance:getDesc()
    if WeaponDesc.guidance == 5 then      
      for _, SAM in pairs(self.SAMSites) do        
        if math.random(1,100) < IADSARMHidePctage and getDistance(SAM.Location, WeaponPoint) < IADSARMHideRangeRadio then          
          self:magnumHide(SAM)            
        end        
      end      
    end
  end 
end

function IADS:onBirth(event)
  local isEWR = false
  local isSAM = false
  local isAWACS = false
  local hasDL = false
  local samType
  local numSAMRadars = 0
  local numTrackRadars = 0
  local numEWRRadars = 0
  local gp = event.initiator:getGroup()
  if gp:getCategory() == 2 then
    for _, unt in pairs(gp:getUnits()) do
      if unt:hasAttribute("Datalink") then
        hasDL = true
      end
      if unt:hasAttribute("EWR") then
        isEWR = true
        numEWRRadars = numEWRRadars + 1
      elseif unt:hasAttribute("SAM TR") then
        isSAM = true
        samType = unt:getTypeName()
        numSAMRadars = numSAMRadars + 1
      end
    end
    if isEWR then
      self.EWRSites[gp:getName()] = {
          ["Name"] = gp:getName(),
          ["EWRGroup"] = gp,
          ["SAMsControlled"] = {},
          ["Location"] = gp:getUnit(1):getPoint(),
          ["numEWRRadars"] = numEWRRadars,
          ["ARMDetected"] = {},
          ["Datalink"] = hasDL,
          ["TrackFiles"] = {},
      }
      isEWR = false 
      isSAM = false
      numEWRRadars = 0
      numSAMRadars = 0
    elseif isSAM and rangeOfSAM(gp) then
      self.SAMSites[gp:getName()] = {
          ["Name"] = gp:getName(),
          ["SAMGroup"] = gp,
          ["Type"] = samType,
          ["Location"] = gp:getUnit(1):getPoint(),
          ["numSAMRadars"] = numSAMRadars,
          ["EngageRange"] = rangeOfSAM(gp),           
          ["ControlledBy"] = {}, 
          ["Enabled"] = true,
          ["Hidden"] = false,
          ["BlinkTimer"] = 0,
          ["ARMDetected"] = {},
          ["Datalink"] = hasDL, 
          ["TrackFiles"] = {},           
      }
      isEWR = false  
      isSAM = false
      numEWRRadars = 0
      numSAMRadars = 0
      gp:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
    end
    self:associateSAMS() 
  elseif gp:getCategory() == 0 then
    local numAWACS = 0
    for _, unt in pairs(gp:getUnits()) do
      if unt:hasAttribute("AWACS") then      
        isAWACS = true
        numAWACS = numAWACS+1
        if unt:hasAttribute("Datalink") then
          hasDL = true      
        end
      end
  
    end 
    if isAWACS then 
      self.AWACSAircraft[gp:getName()] = {
        ["Name"] = gp:getName(),
        ["AWACSGroup"] = gp,
        ["numAWACS"] = numAWACS,
        ["Datalink"] = hasDL,
        ["TrackFiles"] = {},   
       }    
    end
  end  
end

function IADS:disableAllSAMs()
  for _, SAM in pairs(self.SAMSites) do
    SAM.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
    SAM.Enabled = false
  end
end

function IADS:populateLists()
  local isEWR = false
  local isSAM = false
  local isAWACS = false
  local hasDL = false
  local samType
  local numSAMRadars = 0
  local numTrackRadars = 0
  local numEWRRadars = 0
  for _, gp in pairs(coalition.getGroups(1)) do
    if gp:getCategory() == 2 then
      for _, unt in pairs(gp:getUnits()) do
        if unt:hasAttribute("EWR") then
          isEWR = true
          numEWRRadars = numEWRRadars + 1
        elseif unt:hasAttribute("SAM TR") then
          isSAM = true
          samType = unt:getTypeName()
          numSAMRadars = numSAMRadars + 1
        end
        if unt:hasAttribute("Datalink") then
          hasDL = true
        end
      end
      if isEWR then
        self.EWRSites[gp:getName()] = {
            ["Name"] = gp:getName(),
            ["EWRGroup"] = gp,
            ["SAMsControlled"] = {},
            ["Location"] = gp:getUnit(1):getPoint(),
            ["numEWRRadars"] = numEWRRadars,
            ["ARMDetected"] = {},
            ["Datalink"] = hasDL,
            ["TrackFiles"] = {},
        }
        isEWR = false
        isSAM = false
        numEWRRadars = 0
        numSAMRadars = 0
      elseif isSAM and rangeOfSAM(gp) then
        self.SAMSites[gp:getName()] = {
            ["Name"] = gp:getName(),
            ["SAMGroup"] = gp,
            ["Type"] = samType,
            ["Location"] = gp:getUnit(1):getPoint(),
            ["numSAMRadars"] = numSAMRadars,
            ["EngageRange"] = rangeOfSAM(gp),
            ["ControlledBy"] = {},
            ["Enabled"] = true,
            ["Hidden"] = false,
            ["BlinkTimer"] = 0,
            ["ARMDetected"] = {},
            ["Datalink"] = hasDL,
            ["TrackFiles"] = {},
        }
        isEWR = false
        isSAM = false
        numEWRRadars = 0
        numSAMRadars = 0
      end
      self:associateSAMS()
    elseif gp:getCategory() == 0 then
      local numAWACS = 0
      for _, unt in pairs(gp:getUnits()) do
        if unt:hasAttribute("AWACS") then
          isAWACS = true
          numAWACS = numAWACS+1
        end
        if unt:hasAttribute("Datalink") then
          hasDL = true
        end
      end
      if isAWACS then
        self.AWACSAircraft[gp:getName()] = {
          ["Name"] = gp:getName(),
          ["AWACSGroup"] = gp,
          ["numAWACS"] = numAWACS,
          ["Datalink"] = hasDL,
          ["TrackFiles"] = {},
         }
      end
    end
  end
end

function IADS:disableAllSAMs()
  for _, SAM in pairs(self.SAMSites) do
    SAM.SAMGroup:getController():setOption(AI.Option.Ground.id.ALARM_STATE,1)
    SAM.Enabled = false
  end
end

function IADS:sysIADSEventHandler(event)
  local relevents = {
    [world.event.S_EVENT_DEAD]                = self.onDeath,
    [world.event.S_EVENT_SHOT]                = self.onShot,
    [world.event.S_EVENT_BIRTH]               = self.onBirth,
  }
  if relevents[event.id] == nil then
    Logger:debug("sysTicketsEventHandler - not relevent event: "..
      tostring(event.id))
    return
  end
  relevents[event.id](self, event)
end

function IADS:__init(theater)
  assert(theater ~= nil, "value error: theater must be a non-nil value")
  Logger:debug("init system.IADS event handler")
  self.theater = theater
  self.SAMSites = {}
  self.EWRSites = {}
  self.AWACSAircraft = {}
  self.TrackFiles = { ["SAM"] = {},
                      ["EWR"] = {},
                      ["AWACS"] = {},
                    }
  if IADSEnable then
    theater:registerHandler(self.sysIADSEventHandler, self)
    theater:queueCommand(10, Command(self.populateLists, self))
    theater:queueCommand(10, Command(self.EWRTrackFileBuild, self))
    theater:queueCommand(10, Command(self.SAMTrackFileBuild, self))
    theater:queueCommand(10, Command(self.AWACSTrackFileBuild, self))
    theater:queueCommand(10, Command(self.IADSTick, self))
    theater:queueCommand(10, Command(self.SAMCheckHidden, self))
    theater:queueCommand(10, Command(self.BlinkSAM, self))
  end
end

return IADS