AI_AIR_CAP_ZONE = {
    ClassName = "AI_AIR_CAP_ZONE"
}

function AI_AIR_CAP_ZONE:New( AIGroup, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType )
    local AI_Air = AI_AIR:New(AIGroup)
    local AI_Air_Patrol = AI_AIR_PATROL:New( AI_Air, AIGroup, PatrolZone, PatrolFloorAltitude, PatrolCeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, PatrolAltType)
    local self = BASE:Inherit(self, AI_Air_Patrol)

    self.Accomplished = false
    self.Engaging = false
    self.PatrolZone = PatrolZone
    self.DetectedUnits = {}
    self:SetRefreshTimeInterval(30)

    self:AddTransition( { "Patrolling", "Engaging" }, "Engage", "Engaging" ) -- FSM_CONTROLLABLE Transition for type #AI_AIR_CAP_ZONE.
    self:AddTransition( "Engaging", "Fired", "Engaging" ) -- FSM_CONTROLLABLE Transition for type #AI_AIR_CAP_ZONE.
    self:AddTransition( "*", "Destroy", "*" ) -- FSM_CONTROLLABLE Transition for type #AI_AIR_CAP_ZONE.
    self:AddTransition( "Engaging", "Abort", "Patrolling" ) -- FSM_CONTROLLABLE Transition for type #AI_AIR_CAP_ZONE.
    self:AddTransition( "Engaging", "Accomplish", "Patrolling" ) -- FSM_CONTROLLABLE Transition for type #AI_AIR_CAP_ZONE.
    self:AddTransition("*", "Patrol", "Patrolling")

    self:AddTransition("*", "Detect", "*")
    self:AddTransition( "*", "Detected", "*" )

    return self
    
end
  
  
  --- Set the Engage Zone which defines where the AI will engage bogies. 
  -- @param #AI_AIR_CAP_ZONE self
  -- @param Core.Zone#ZONE EngageZone The zone where the AI is performing CAP.
  -- @return #AI_AIR_CAP_ZONE self
  function AI_AIR_CAP_ZONE:SetEngageZone( EngageZone )
    self:F2()
  
    if EngageZone then  
      self.EngageZone = EngageZone
    else
      self.EngageZone = nil
    end
  end
  
  --- Set the Engage Range when the AI will engage with airborne enemies. 
  -- @param #AI_AIR_CAP_ZONE self
  -- @param #number EngageRange The Engage Range.
  -- @return #AI_AIR_CAP_ZONE self
  function AI_AIR_CAP_ZONE:SetEngageRange( EngageRange )
    self:F2()
  
    if EngageRange then  
      self.EngageRange = EngageRange
    else
      self.EngageRange = nil
    end
  end

function AI_AIR_CAP_ZONE:SetDetectionOn()
  self:F2()
  
  self.DetectOn = true
end
  
  --- Set the detection off. The AI will NOT detect for targets.
  -- However, the list of already detected targets will be kept and can be enquired!
  -- @param #AI_AIR_CAP_ZONE self
  -- @return #AI_AIR_CAP_ZONE self
function AI_AIR_CAP_ZONE:SetDetectionOff()
  self:F2()
  
  self.DetectOn = false
end

function AI_AIR_CAP_ZONE:SetDetectionActivated()
  self:F2()
  
  self:ClearDetectedUnits()
  self.DetectActivated = true
  self:__Detect( -self.DetectInterval )
end

--- Deactivate the detection. The AI will NOT detect for targets.
-- @param #AI_AIR_CAP_ZONE self
-- @return #AI_AIR_CAP_ZONE self
function AI_AIR_CAP_ZONE:SetDetectionDeactivated()
  self:F2()
  
  self:ClearDetectedUnits()
  self.DetectActivated = false
end

function AI_AIR_CAP_ZONE:SetRefreshTimeInterval( Seconds )
  self:F2()

  if Seconds then  
    self.DetectInterval = Seconds
  else
    self.DetectInterval = 30
  end
end

--- Set the detection zone where the AI is detecting targets.
-- @param #AI_AIR_CAP_ZONE self
-- @param Core.Zone#ZONE DetectionZone The zone where to detect targets.
-- @return #AI_AIR_CAP_ZONE self
function AI_AIR_CAP_ZONE:SetDetectionZone( DetectionZone )
  self:F2()

  if DetectionZone then  
    self.DetectZone = DetectionZone
  else
    self.DetectZone = nil
  end
end

--- Gets a list of @{Wrapper.Unit#UNIT}s that were detected by the AI.
-- No filtering is applied, so, ANY detected UNIT can be in this list.
-- It is up to the mission designer to use the @{Wrapper.Unit} class and methods to filter the targets.
-- @param #AI_AIR_CAP_ZONE self
-- @return #table The list of @{Wrapper.Unit#UNIT}s
function AI_AIR_CAP_ZONE:GetDetectedUnits()
  self:F2()

  return self.DetectedUnits 
end

--- Clears the list of @{Wrapper.Unit#UNIT}s that were detected by the AI.
-- @param #AI_AIR_CAP_ZONE self
function AI_AIR_CAP_ZONE:ClearDetectedUnits()
  self:F2()
  self.DetectedUnits = {}
end

function AI_AIR_CAP_ZONE:OnEventCrashOrDead(EventData)
    if self.DetectedUnits[EventData.IniUnit] then
        self:__Destroy(1, EventData)
    end
end
  --- onafter State Transition for Event Start.
  -- @param #AI_AIR_CAP_ZONE self
  -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
function AI_AIR_CAP_ZONE:onafterStart( Controllable, From, Event, To )
  
    -- Call the parent Start event handler
    self:GetParent(self, AI_AIR_CAP_ZONE).onafterStart( self, Controllable, From, Event, To )
    
    self:HandleEvent(EVENTS.Crash, self.OnEventCrash)
    self:HandleEvent(EVENTS.Dead, self.OnEventDead)
    self:HandleEvent(EVENTS.PilotDead, self.OnEventPilotDead)
    self:HandleEvent(EVENTS.Ejection, self.OnEventEjection)
    self:SetDetectionActivated()
    self:SetDetectionOn()

    self:__Patrol(2)
end

function AI_AIR_CAP_ZONE:onafterStatus()
    if self.Controllable and self.Controllable:IsAlive() then
  
        local RTB = false
        
        local DistanceFromHomeBase = self.HomeAirbase:GetCoordinate():Get2DDistance( self.Controllable:GetCoordinate() )
        
        if not self:Is( "Holding" ) and not self:Is( "Returning" ) then
            local DistanceFromHomeBase = self.HomeAirbase:GetCoordinate():Get2DDistance( self.Controllable:GetCoordinate() )
          
            if DistanceFromHomeBase > self.DisengageRadius then
                self:E( self.Controllable:GetName() .. " is too far from home base, RTB!" )
                self:Hold( 300 )
                RTB = false
            end
        end    
    
        if not self:Is( "Fuel" ) and not self:Is( "Home" ) then
          
            local Fuel = self.Controllable:GetFuelMin()
          
            -- If the fuel in the controllable is below the treshold percentage,
            -- then send for refuel in case of a tanker, otherwise RTB.
            if Fuel < self.FuelThresholdPercentage then
                BASE:E("Checking fuel")
                if self.TankerName then
                    self:E( self.Controllable:GetName() .. " is out of fuel: " .. Fuel .. " ... Refuelling at Tanker!" )
                    --self:Refuel()
                else
                    self:E( self.Controllable:GetName() .. " is out of fuel: " .. Fuel .. " ... RTB!" )
                    local OldAIControllable = self.Controllable
              
                    local OrbitTask = OldAIControllable:TaskOrbitCircle( math.random( self.PatrolFloorAltitude, self.PatrolCeilingAltitude ), self.PatrolMinSpeed )
                    local TimedOrbitTask = OldAIControllable:TaskControlled( OrbitTask, OldAIControllable:TaskCondition(nil,nil,nil,nil,self.OutOfFuelOrbitTime,nil ) )
                    OldAIControllable:SetTask( TimedOrbitTask, 10 )
        
                    --self:Fuel()
                    RTB = true
                end
            else
            end
        end
        
        -- TODO: Check GROUP damage function.
        local Damage = self.Controllable:GetLife()
        local InitialLife = self.Controllable:GetLife0()
        
        -- If the group is damaged, then RTB.
        -- Note that a group can consist of more units, so if one unit is damaged of a group, the mission may continue.
        -- The damaged unit will RTB due to DCS logic, and the others will continue to engage.
        if ( Damage / InitialLife ) < self.PatrolDamageThreshold then
            self:E( self.Controllable:GetName() .. " is damaged: " .. Damage .. " ... RTB!" )
            self:Damaged()
            RTB = true
            self:SetStatusOff()
        end
        
        -- Check if planes went RTB and are out of control.
        -- We only check if planes are out of control, when they are in duty.
        if self.Controllable:HasTask() == false then
            if not self:Is( "Started" ) and 
                not self:Is( "Stopped" ) and
                not self:Is( "Fuel" ) and 
                not self:Is( "Damaged" ) and 
                not self:Is( "Home" ) then
                if self.IdleCount >= 10 then
                    if Damage ~= InitialLife then
                        self:Damaged()
                    else  
                        self:E( self.Controllable:GetName() .. " control lost! " )
                
                        self:LostControl()
                    end
                else
                    self.IdleCount = self.IdleCount + 1
                end
            end
        else
            self.IdleCount = 0
        end
    
        if RTB == true then
            self:__RTB( self.TaskDelay )
        end
    
        if not self:Is("Home") then
            self:__Status( 10 )
        end
        
    end
end

function AI_AIR_CAP_ZONE:onbeforeDetect( Controllable, From, Event, To )

  return self.DetectOn and self.DetectActivated
end

function AI_AIR_CAP_ZONE:onafterDetect( Controllable, From, Event, To )
  local Detected = false

  local DetectedTargets = Controllable:GetDetectedTargets()
  for TargetID, Target in pairs( DetectedTargets or {} ) do
    local TargetObject = Target.object

    if TargetObject and TargetObject:isExist() and TargetObject.id_ < 50000000 then

      local TargetUnit = UNIT:Find( TargetObject )
      local TargetUnitName = TargetUnit:GetName()
      
      if self.DetectionZone then
        if TargetUnit:IsInZone( self.DetectionZone ) then
          self:T( {"Detected ", TargetUnit } )
          if self.DetectedUnits[TargetUnit] == nil then
            self.DetectedUnits[TargetUnit] = true
          end
          Detected = true 
        end
      else       
        if self.DetectedUnits[TargetUnit] == nil then
          self.DetectedUnits[TargetUnit] = true
        end
        Detected = true
      end
    end
  end

  self:__Detect( -self.DetectInterval )
  
  if Detected == true then
    self:__Detected( 1.5 )
  end
end
  
function AI_AIR_CAP_ZONE.EngageRoute( EngageGroup, Fsm )
  
  EngageGroup:F( { "AI_AIR_CAP_ZONE.EngageRoute:", EngageGroup:GetName() } )
  
  if EngageGroup:IsAlive() then
    Fsm:__Engage( 1 )
  end
end
  
  
  
  --- @param #AI_AIR_CAP_ZONE self
  -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  function AI_AIR_CAP_ZONE:onbeforeEngage( Controllable, From, Event, To )
    
    if self.Accomplished == true then
      return false
    end
  end
  
  --- @param #AI_AIR_CAP_ZONE self
  -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  function AI_AIR_CAP_ZONE:onafterDetected( Controllable, From, Event, To )
  
    if From ~= "Engaging" then
    
      local Engage = false
    
      for DetectedUnit, Detected in pairs( self.DetectedUnits ) do
      
        local DetectedUnit = DetectedUnit -- Wrapper.Unit#UNIT
        self:T( DetectedUnit )
        if DetectedUnit:IsAlive() and DetectedUnit:IsAir() then
          Engage = true
          break
        end
      end
    
      if Engage == true then
        self:F( 'Detected -> Engaging' )
        self:__Engage( 1 )
      end
    end
  end
  
  
  --- @param #AI_AIR_CAP_ZONE self
  -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  function AI_AIR_CAP_ZONE:onafterAbort( Controllable, From, Event, To )
    Controllable:ClearTasks()
    self:Patrol()
  end
  
  
  
  
  --- @param #AI_AIR_CAP_ZONE self
  -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  function AI_AIR_CAP_ZONE:onafterEngage( Controllable, From, Event, To )
  
    if Controllable:IsAlive() then
  
      local EngageRoute = {}
  
      --- Calculate the current route point.
      local CurrentVec2 = self.Controllable:GetVec2()
      
      --TODO: Create GetAltitude function for GROUP, and delete GetUnit(1).
      local CurrentAltitude = self.Controllable:GetUnit(1):GetAltitude()
      local CurrentPointVec3 = POINT_VEC3:New( CurrentVec2.x, CurrentAltitude, CurrentVec2.y )
      local ToEngageZoneSpeed = self.PatrolMaxSpeed
      local CurrentRoutePoint = CurrentPointVec3:WaypointAir( 
          self.PatrolAltType, 
          POINT_VEC3.RoutePointType.TurningPoint, 
          POINT_VEC3.RoutePointAction.TurningPoint, 
          ToEngageZoneSpeed, 
          true 
        )
      
      EngageRoute[#EngageRoute+1] = CurrentRoutePoint
  
      
       --- Find a random 2D point in PatrolZone.
      local ToTargetVec2 = self.PatrolZone:GetRandomVec2()
      self:T2( ToTargetVec2 )
  
      --- Define Speed and Altitude.
      local ToTargetAltitude = math.random( self.EngageFloorAltitude, self.EngageCeilingAltitude )
      local ToTargetSpeed = math.random( self.PatrolMinSpeed, self.PatrolMaxSpeed )
      self:T2( { self.PatrolMinSpeed, self.PatrolMaxSpeed, ToTargetSpeed } )
      
      --- Obtain a 3D @{Point} from the 2D point + altitude.
      local ToTargetPointVec3 = POINT_VEC3:New( ToTargetVec2.x, ToTargetAltitude, ToTargetVec2.y )
      
      --- Create a route point of type air.
      local ToPatrolRoutePoint = ToTargetPointVec3:WaypointAir( 
        self.PatrolAltType, 
        POINT_VEC3.RoutePointType.TurningPoint, 
        POINT_VEC3.RoutePointAction.TurningPoint, 
        ToTargetSpeed, 
        true 
      )
  
      EngageRoute[#EngageRoute+1] = ToPatrolRoutePoint
  
      Controllable:OptionROEOpenFire()
      Controllable:OptionROTEvadeFire()
  
      local AttackTasks = {}
  
      for DetectedUnit, Detected in pairs( self.DetectedUnits ) do
        local DetectedUnit = DetectedUnit -- Wrapper.Unit#UNIT
        self:T( { DetectedUnit, DetectedUnit:IsAlive(), DetectedUnit:IsAir() } )
        if DetectedUnit:IsAlive() and DetectedUnit:IsAir() then
          if self.EngageZone then
            if DetectedUnit:IsInZone( self.EngageZone ) then
              self:F( {"Within Zone and Engaging ", DetectedUnit } )
              AttackTasks[#AttackTasks+1] = Controllable:TaskAttackUnit( DetectedUnit )
            end
          else        
            if self.EngageRange then
              if DetectedUnit:GetPointVec3():Get2DDistance(Controllable:GetPointVec3() ) <= self.EngageRange then
                self:F( {"Within Range and Engaging", DetectedUnit } )
                AttackTasks[#AttackTasks+1] = Controllable:TaskAttackUnit( DetectedUnit )
              end
            else
              AttackTasks[#AttackTasks+1] = Controllable:TaskAttackUnit( DetectedUnit )
            end
          end
        else
          self.DetectedUnits[DetectedUnit] = nil
        end
      end
  
      if #AttackTasks == 0 then
        self:E("No targets found -> Going back to Patrolling")
        self:__Abort( 1 )
        self:Patrol()
        self:SetDetectionActivated()
      else
  
        AttackTasks[#AttackTasks+1] = Controllable:TaskFunction( "AI_AIR_CAP_ZONE.EngageRoute", self )
        EngageRoute[1].task = Controllable:TaskCombo( AttackTasks )
        
        self:SetDetectionDeactivated()
      end
      
      Controllable:Route( EngageRoute, 0.5 )
    
    end
  end
  
  --- @param #AI_AIR_CAP_ZONE self
  -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  function AI_AIR_CAP_ZONE:onafterAccomplish( Controllable, From, Event, To )
    self.Accomplished = true
    self:SetDetectionOff()
  end
  
  --- @param #AI_AIR_CAP_ZONE self
  -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  -- @param Core.Event#EVENTDATA EventData
  function AI_AIR_CAP_ZONE:onafterDestroy( Controllable, From, Event, To, EventData )
    BASE:E("Inside AI_AIR_CAP_ZONE:onafterDestroy")
    if EventData.IniUnit then
      self.DetectedUnits[EventData.IniUnit] = nil
    end
  end
  
  --- @param #AI_AIR_CAP_ZONE self
  -- @param Core.Event#EVENTDATA EventData
  function AI_AIR_CAP_ZONE:OnEventDead( EventData )
    self:F( { "EventDead", EventData } )
  
    if EventData.IniDCSUnit then
      if self.DetectedUnits and self.DetectedUnits[EventData.IniUnit] then
        self:__Destroy( 1, EventData )
      end
    end
  end

function AI_AIR_CAP_ZONE:OnEventPilotDead(EventData)
    BASE:E(EventData.IniUnitName .. " pilot has died")
    if self.DetectedUnits and self.DetectedUnits[EventData.IniUnit] then
        self:__Destroy(1, EventData)
    end
    
end

function AI_AIR_CAP_ZONE:OnEventEjection(EventData)
    BASE:E(EventData.IniUnitName .. " pilot has ejected")
    if self.DetectedUnits and self.DetectedUnits[EventData.IniUnit] then
        self:__Destroy(1, EventData)
    end
    
end