-- Operation Enduring Odyssey MOOSE OPTIONS v2 -- 

-- Airboss Settings Stennis --

local airbossStennis=AIRBOSS:New("CV-74 Stennis", "CV-74 Stennis")
airbossStennis:Start()

--AirbossBasicSettings-- 
airbossStennis:SetTACAN(74, "X", "C74")
airbossStennis:SetICLS(16, "C74")
airbossStennis:SetLSORadio(127.500, "AM")
airbossStennis:SetMarshalRadio(238.500, "AM")
airbossStennis:SetRecoveryCase(1)
airbossStennis:SetCarrierControlledArea(50)
airbossStennis:SetDefaultPlayerSkill("Naval Aviator")
local CarrierIncludeSet = SET_GROUP:New():FilterPrefixes({"StennisRecoveryTanker", "DARKSTAR"}):FilterStart()
airbossStennis:SetSquadronAI(CarrierIncludeSet)

--AirbossRadioSettings--
airbossStennis:SetSoundfilesFolder("Airboss Soundfiles/")
airbossStennis:SetRadioRelayMarshal("MarshalRadioRelay")
airbossStennis:SetRadioRelayLSO("LSORadioRelay")

--AirbossBehaviourSettings-- 
airbossStennis:SetInitialMaxAlt(1000)
airbossStennis:SetAirbossNiceGuy(true)
airbossStennis:SetMaxSectionSize(4)
--airbossStennis:SetMaxMarshalStack(6)
airbossStennis:SetMaxFlightsPerStack(2)
airbossStennis:SetCollisionDistance(15)
airbossStennis:SetMenuRecovery(20, 25, true, 30)
airbossStennis:SetVoiceOversLSOByRaynor()
airbossStennis:SetVoiceOversMarshalByFF()

--RecoveryTankerSettings-- 
TexacoStennis=RECOVERYTANKER:New(UNIT:FindByName("CV-74 Stennis"), "StennisRecoveryTanker")
TexacoStennis:Start()
TexacoStennis:SetTakeoffAir()
TexacoStennis:SetTACAN(16, "TKR")
TexacoStennis:SetRadio(128.500)
airbossStennis:SetRecoveryTanker(TexacoStennis)

--AirbossTrapSheets-- 
--airbossStennis:SetAutoSave()

--Rescue Helo--
RescueheloStennis=RESCUEHELO:New(UNIT:FindByName("CV-74 Stennis"), "Stennis Rescue Helo")
RescueheloStennis:SetTakeoffAir()
RescueheloStennis:SetRescueOff()
RescueheloStennis:Start()

-- AirbasePolice-- 
AirbasePoliceCaucasus = ATC_GROUND_PERSIANGULF:New() 
--REMEMBER to Install Ciribob Slot Blocker for kicking --

--[[ATIS Setup-- 
atisAlDhafra=ATIS:New(AIRBASE.PersianGulf.Al_Dhafra_AB, 308.350)
atisAlDhafra:SetRadioRelayUnitName("AlDhafraRadioRelay") 
atisAlDhafra:SetTowerFrequencies({126.500, 251.000})
atisAlDhafra:SetTACAN(96)
--atisAlDhafra:SetVOR(114.9)
--atisAlDhafra:SetActiveRunway("L")
atisAlDhafra:SetRadioPower(1000)
atisAlDhafra:Start()

atisAlMinhad=ATIS:New(AIRBASE.PersianGulf.Al_Minhad_AB, 248.600)
atisAlMinhad:SetRadioRelayUnitName("AlMinhadRadioRelay")
atisAlMinhad:SetTowerFrequencies({121.800, 250.100})
atisAlMinhad:SetTACAN(99)
--atisAlMinhad:AddILS(110.75, "27")
--atisAlMinhad:AddILS(110.70, "9")
atisAlMinhad:SetRadioPower(1000)
atisAlMinhad:Start()]]--

-- Handle Blue AWACS and Tankers in OEO Using MOOSE --

function ARCO()
  ARCOSpawner = SPAWN:New("ARCO")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  :InitRepeatOnLanding()
  :InitCleanUp(10)
  
 end
 
function SHELL()
  SHELLSpawner = SPAWN:New("SHELL")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  :InitRepeatOnLanding()
  :InitCleanUp(10)
  
 end

function MAGIC()
  MAGICSpawner = SPAWN:New("MAGIC")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  :InitRepeatOnLanding()
  :InitCleanUp(10)
  
 end
 
function DARKSTAR()
  DARKSTARSpawner = SPAWN:New("DARKSTAR")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  :InitRepeatOnLanding()
  :InitCleanUp(10)
  
end
 
ARCO()
SHELL()
MAGIC()
DARKSTAR()

-- RED CAP Squadrons Setup--

function SQN1()
	SQN1Spawn = SPAWN:NewWithAlias("SQN 1", "Iranian Tiger")
		:OnSpawnGroup(
			function(SQN1Manager)
				local SQN_1_CAP = ZONE_POLYGON:New("SQN 1 CAP", GROUP:FindByName("SQN 1 CAP"))
				local SQN_1_DETECT = ZONE_POLYGON:New("SQN 1 DETECT", GROUP:FindByName("SQN 1 DETECT"))
				local SQN_1_ENGAGE = ZONE_POLYGON:New("SQN 1 ENGAGE", GROUP:FindByName("SQN 1 ENGAGE"))
				local SQN_1_PATROL = AI_AIR_CAP_ZONE:New(SQN1Manager, SQN_1_CAP, 8000, 9800, 650, 800, "BARO")
				SQN_1_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Bandar_e_Jask_airfield)
				SQN_1_PATROL:SetEngageZone(SQN_1_ENGAGE)
				--SQN_1_PATROL:SetFuelThreshold(0.2, 60)
				SQN_1_PATROL:SetDamageThreshold(0.75)
				SQN_1_PATROL:SetEngageRange(60000)
				SQN_1_PATROL:SetDisengageRadius(80000)
				SQN_1_PATROL:SetDetectionOn()
				SQN_1_PATROL:SetRefreshTimeInterval(120)
				SQN_1_PATROL:SetDetectionZone(SQN_1_DETECT)
				SQN_1_PATROL:SetControllable(SQN1Manager)
				SQN_1_PATROL:SetRaceTrackPattern(10000, 20000, 180, 210, nil, nil, SQN_1_CAP:GetRandomCoordinate())
				SQN_1_PATROL:__Start(3)
				
				function SQN_1_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_1_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_1_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_1_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
				
			end
			
		)
		:InitLimit(4, 0)
		:SpawnScheduled(360, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end

function SQN2()
	SQN2Spawn = SPAWN:NewWithAlias("SQN 2", "Iranian Phantom")
		:OnSpawnGroup(
			function(SQN2Manager)
				local SQN_2_CAP = ZONE_POLYGON:New("SQN 2 CAP", GROUP:FindByName("SQN 2 CAP"))
				local SQN_2_DETECT = ZONE_POLYGON:New("SQN 2 DETECT", GROUP:FindByName("SQN 2 DETECT"))
				local SQN_2_ENGAGE = ZONE_POLYGON:New("SQN 2 ENGAGE", GROUP:FindByName("SQN 2 ENGAGE"))
				local SQN_2_PATROL = AI_AIR_CAP_ZONE:New(SQN2Manager, SQN_2_CAP, 7500, 8500, 650, 800, "BARO")
				SQN_2_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Havadarya)
				SQN_2_PATROL:SetEngageZone(SQN_2_ENGAGE)
				--SQN_2_PATROL:SetFuelThreshold(0.2, 60)
				SQN_2_PATROL:SetDamageThreshold(0.75)
				SQN_2_PATROL:SetEngageRange(100000)
				SQN_2_PATROL:SetDisengageRadius(200000)
				SQN_2_PATROL:SetDetectionOn()
				SQN_2_PATROL:SetRefreshTimeInterval(120)
				SQN_2_PATROL:SetDetectionZone(SQN_2_DETECT)
				SQN_2_PATROL:SetControllable(SQN2Manager)
				SQN_2_PATROL:SetRaceTrackPattern(10000, 20000, 180, 180, nil, nil, SQN_2_CAP:GetRandomCoordinate())
				SQN_2_PATROL:__Start(3)
				
				function SQN_2_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_2_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_2_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_2_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
			
			end
			
		)
		:InitLimit(2, 0)
		:SpawnScheduled(360, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end

function SQN3()
	SQN3Spawn = SPAWN:NewWithAlias("SQN 3", "Iranian Fulcrum A")
		:OnSpawnGroup(
			function(SQN3Manager)
				local SQN_3_CAP = ZONE_POLYGON:New("SQN 3 CAP", GROUP:FindByName("SQN 3 CAP"))
				local SQN_3_DETECT = ZONE_POLYGON:New("SQN 3 DETECT", GROUP:FindByName("SQN 3 DETECT"))
				local SQN_3_ENGAGE = ZONE_POLYGON:New("SQN 3 ENGAGE", GROUP:FindByName("SQN 3 ENGAGE"))
				local SQN_3_PATROL = AI_AIR_CAP_ZONE:New(SQN3Manager, SQN_3_CAP, 6100, 8500, 650, 800, "BARO")
				SQN_3_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Lar_Airbase)
				SQN_3_PATROL:SetEngageZone(SQN_3_ENGAGE)
				--SQN_3_PATROL:SetFuelThreshold(0.2, 60)
				SQN_3_PATROL:SetDamageThreshold(0.75)
				SQN_3_PATROL:SetEngageRange(100000)
				SQN_3_PATROL:SetDisengageRadius(200000)
				SQN_3_PATROL:SetDetectionOn()
				SQN_3_PATROL:SetRefreshTimeInterval(120)
				SQN_3_PATROL:SetDetectionZone(SQN_3_DETECT)
				SQN_3_PATROL:SetControllable(SQN3Manager)
				SQN_3_PATROL:SetRaceTrackPattern(10000, 20000, 160, 200, nil, nil, SQN_3_CAP:GetRandomCoordinate())
				SQN_3_PATROL:__Start(3)
				
				function SQN_3_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_3_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_3_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_3_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
				
			end
			
		)
		:InitLimit(2, 0)
		:SpawnScheduled(30, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end

function SQN4()
	SQN4Spawn = SPAWN:NewWithAlias("SQN 4", "Iranian Fulcrum B")
		:OnSpawnGroup(
			function(SQN4Manager)
				local SQN_4_CAP = ZONE_POLYGON:New("SQN 4 CAP", GROUP:FindByName("SQN 4 CAP"))
				local SQN_4_DETECT = ZONE_POLYGON:New("SQN 4 DETECT", GROUP:FindByName("SQN 4 DETECT"))
				local SQN_4_ENGAGE = ZONE_POLYGON:New("SQN 4 ENGAGE", GROUP:FindByName("SQN 4 ENGAGE"))
				local SQN_4_PATROL = AI_AIR_CAP_ZONE:New(SQN4Manager, SQN_4_CAP, 6100, 8500, 650, 800, "BARO")
				SQN_4_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Lar_Airbase)
				SQN_4_PATROL:SetEngageZone(SQN_4_ENGAGE)
				--SQN_4_PATROL:SetFuelThreshold(0.2, 60)
				SQN_4_PATROL:SetDamageThreshold(0.75)
				SQN_4_PATROL:SetEngageRange(100000)
				SQN_4_PATROL:SetDisengageRadius(200000)
				SQN_4_PATROL:SetDetectionOn()
				SQN_4_PATROL:SetRefreshTimeInterval(120)
				SQN_4_PATROL:SetDetectionZone(SQN_4_DETECT)
				SQN_4_PATROL:SetControllable(SQN1Manager)
				SQN_4_PATROL:SetRaceTrackPattern(10000, 20000, 160, 200, nil, nil, SQN_4_CAP:GetRandomCoordinate())
				SQN_4_PATROL:__Start(3)
				
				function SQN_4_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_4_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_4_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_4_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
				
			end
			
		)
		:InitLimit(2, 0)
		:SpawnScheduled(30, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end

function SQN5()
	SQN5Spawn = SPAWN:NewWithAlias("SQN 5", "Iranian Fishbed A")
		:OnSpawnGroup(
			function(SQN5Manager)
				local SQN_5_CAP = ZONE_POLYGON:New("SQN 5 CAP", GROUP:FindByName("SQN 5 CAP"))
				local SQN_5_DETECT = ZONE_POLYGON:New("SQN 5 DETECT", GROUP:FindByName("SQN 5 DETECT"))
				local SQN_5_ENGAGE = ZONE_POLYGON:New("SQN 5 ENGAGE", GROUP:FindByName("SQN 5 ENGAGE"))
				local SQN_5_PATROL = AI_AIR_CAP_ZONE:New(SQN5Manager, SQN_5_CAP, 5500, 8000, 650, 800, "BARO")
				SQN_5_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Bandar_Lengeh)
				SQN_5_PATROL:SetEngageZone(SQN_5_ENGAGE)
				--SQN_5_PATROL:SetFuelThreshold(0.2, 60)
				SQN_5_PATROL:SetDamageThreshold(0.75)
				SQN_5_PATROL:SetEngageRange(100000)
				SQN_5_PATROL:SetDisengageRadius(200000)
				SQN_5_PATROL:SetDetectionOn()
				SQN_5_PATROL:SetRefreshTimeInterval(120)
				SQN_5_PATROL:SetDetectionZone(SQN_5_DETECT)
				SQN_5_PATROL:SetControllable(SQN5Manager)
				SQN_5_PATROL:SetRaceTrackPattern(10000, 20000, 150, 180, nil, nil, SQN_5_CAP:GetRandomCoordinate())
				SQN_5_PATROL:__Start(3)
				
				function SQN_5_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_5_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_5_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_5_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
				
			end
			
		)
		:InitLimit(4, 0)
		:SpawnScheduled(360, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end

function SQN6()
	SQN6Spawn = SPAWN:NewWithAlias("SQN 6", "Iranian Fishbed B")
		:OnSpawnGroup(
			function(SQN6Manager)
				local SQN_6_CAP = ZONE_POLYGON:New("SQN 6 CAP", GROUP:FindByName("SQN 6 CAP"))
				local SQN_6_DETECT = ZONE_POLYGON:New("SQN 6 DETECT", GROUP:FindByName("SQN 6 DETECT"))
				local SQN_6_ENGAGE = ZONE_POLYGON:New("SQN 6 ENGAGE", GROUP:FindByName("SQN 6 ENGAGE"))
				local SQN_6_PATROL = AI_AIR_CAP_ZONE:New(SQN6Manager, SQN_6_CAP, 5500, 8000, 650, 800, "BARO")
				SQN_6_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Kish_International_Airport)
				SQN_6_PATROL:SetEngageZone(SQN_6_ENGAGE)
				--SQN_6_PATROL:SetFuelThreshold(0.2, 60)
				SQN_6_PATROL:SetDamageThreshold(0.75)
				SQN_6_PATROL:SetEngageRange(100000)
				SQN_6_PATROL:SetDisengageRadius(200000)
				SQN_6_PATROL:SetDetectionOn()
				SQN_6_PATROL:SetRefreshTimeInterval(120)
				SQN_6_PATROL:SetDetectionZone(SQN_6_DETECT)
				SQN_6_PATROL:SetControllable(SQN6Manager)
				SQN_6_PATROL:SetRaceTrackPattern(10000, 20000, 150, 180, nil, nil, SQN_6_CAP:GetRandomCoordinate())
				SQN_6_PATROL:__Start(3)
				
				function SQN_6_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_6_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_6_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_6_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
				
			end
			
		)
		:InitLimit(2, 0)
		:SpawnScheduled(360, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end

function SQN7()
	SQN7Spawn = SPAWN:NewWithAlias("SQN 7", "Iranian Tomcat A")
		:OnSpawnGroup(
			function(SQN7Manager)
				local SQN_7_CAP = ZONE_POLYGON:New("SQN 7 CAP", GROUP:FindByName("SQN 7 CAP"))
				local SQN_7_DETECT = ZONE_POLYGON:New("SQN 7 DETECT", GROUP:FindByName("SQN 7 DETECT"))
				local SQN_7_ENGAGE = ZONE_POLYGON:New("SQN 7 ENGAGE", GROUP:FindByName("SQN 7 ENGAGE"))
				local SQN_7_PATROL = AI_AIR_CAP_ZONE:New(SQN7Manager, SQN_7_CAP, 9000, 9800, 650, 800, "BARO")
				SQN_7_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Lar_Airbase)
				SQN_7_PATROL:SetEngageZone(SQN_7_ENGAGE)
				--SQN_7_PATROL:SetFuelThreshold(0.2, 60)
				SQN_7_PATROL:SetDamageThreshold(0.75)
				SQN_7_PATROL:SetEngageRange(100000)
				SQN_7_PATROL:SetDisengageRadius(200000)
				SQN_7_PATROL:SetDetectionOn()
				SQN_7_PATROL:SetRefreshTimeInterval(120)
				SQN_7_PATROL:SetDetectionZone(SQN_7_DETECT)
				SQN_7_PATROL:SetControllable(SQN7Manager)
				SQN_7_PATROL:SetRaceTrackPattern(10000, 20000, 180, 180, nil, nil, SQN_7_CAP:GetRandomCoordinate())
				SQN_7_PATROL:__Start(3)
				
				function SQN_7_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_7_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_7_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_7_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
				
			end
			
		)
		:InitLimit(2, 0)
		:SpawnScheduled(360, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end

function SQN8()
	SQN8Spawn = SPAWN:NewWithAlias("SQN 8", "Iranian Tomcat B")
		:OnSpawnGroup(
			function(SQN8Manager)
				local SQN_8_CAP = ZONE_POLYGON:New("SQN 8 CAP", GROUP:FindByName("SQN 8 CAP"))
				local SQN_8_DETECT = ZONE_POLYGON:New("SQN 8 DETECT", GROUP:FindByName("SQN 8 DETECT"))
				local SQN_8_ENGAGE = ZONE_POLYGON:New("SQN 8 ENGAGE", GROUP:FindByName("SQN 8 ENGAGE"))
				local SQN_8_PATROL = AI_AIR_CAP_ZONE:New(SQN8Manager, SQN_8_CAP, 9000, 9800, 650, 800, "BARO")
				SQN_8_PATROL:SetHomeAirbase(AIRBASE.PersianGulf.Lar_Airbase)
				SQN_8_PATROL:SetEngageZone(SQN_8_ENGAGE)
				--SQN_8_PATROL:SetFuelThreshold(0.2, 60)
				SQN_8_PATROL:SetDamageThreshold(0.75)
				SQN_8_PATROL:SetEngageRange(100000)
				SQN_8_PATROL:SetDisengageRadius(200000)
				SQN_8_PATROL:SetDetectionOn()
				SQN_8_PATROL:SetRefreshTimeInterval(120)
				SQN_8_PATROL:SetDetectionZone(SQN_8_DETECT)
				SQN_8_PATROL:SetControllable(SQN8Manager)
				SQN_8_PATROL:SetRaceTrackPattern(10000, 20000, 180, 180, nil, nil, SQN_8_CAP:GetRandomCoordinate())
				SQN_8_PATROL:__Start(3)
				
				function SQN_8_PATROL:OnAfterStart(Controllable, From, Event, To)
                    SQN_8_PATROL:HandleEvent(EVENTS.PilotDead)
                    SQN_8_PATROL:HandleEvent(EVENTS.Ejection)
                    
                end

                function SQN_8_PATROL:onafterHome(Defender, From, Event, To, Action)
                    BASE:E(Defender:GetName() .. " Inside Fsm:onafterHome")
                    self:F({"CAP Home", Defender:GetName()})
                    self:GetParent(self).onafterHome( self, AIGroup, From, Event, To )
                    Defender:Destroy()
                end
				
			end
			
		)
		:InitLimit(2, 0)
		:SpawnScheduled(360, 0.5)
		:InitRepeatOnLanding()
		:InitCleanUp(10)

end


-- Squadrons Initiate --

SQN1()
SQN2()
SQN3()
SQN4()
SQN5()
SQN6()
SQN7()
SQN8()

-- end --