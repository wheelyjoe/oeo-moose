-- OPERATION ENDURING ODYSSEY COMBINED SCRIPTS ---


-- MOOSE FUNCTIONS --

-- Airboss Settings Stennis --

--[[local airbossStennis=AIRBOSS:New("CV-74 Stennis", "CV-74 Stennis")
airbossStennis:Start()

--AirbossBasicSettings-- 
airbossStennis:SetTACAN(74, "X", "C74")
airbossStennis:SetICLS(16, "C74")
airbossStennis:SetLSORadio(127.500, "AM")
airbossStennis:SetMarshalRadio(238.500, "AM")
airbossStennis:SetRecoveryCase(1)
airbossStennis:SetCarrierControlledArea(50)
airbossStennis:SetDefaultPlayerSkill("Naval Aviator")
local CarrierIncludeSet = SET_GROUP:New():FilterPrefixes({"StennisRecoveryTanker"}):FilterStart()
--local CarrierIncludeSet = SET_GROUP:New():FilterPrefixes({"StennisRecoveryTanker", "DARKSTAR"}):FilterStart()
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
airbossStennis:SetVoiceOversMarshalByFF()]]--

--RecoveryTankerSettings-- 
TexacoStennis=RECOVERYTANKER:New(UNIT:FindByName("CV-74 Stennis"), "StennisRecoveryTanker")
TexacoStennis:SetTakeoff(SPAWN.Takeoff.Air)
TexacoStennis:SetTACAN(16, "TXO")
TexacoStennis:SetRadio(128.5)
--TexacoStennis:SetRecoveryAirboss(true)
TexacoStennis:Start()
--airbossStennis:SetRecoveryTanker(TexacoStennis)

--[[AWACS Settings--
DarkstarStennis=RECOVERYTANKER:New(UNIT:FindByName("CV-74 Stennis"), "DARKSTAR")
DarkstarStennis:Start()
DarkstarStennis:SetTakeoffAir()
DarkstarStennis:SetAltitude(28000)
DarkstarStennis:SetRadio(235.000)
airbossStennis:SetAWACS(DarkstarStennis)

--AirbossTrapSheets-- 
--airbossStennis:SetAutoSave()

--Rescue Helo--
RescueheloStennis=RESCUEHELO:New(UNIT:FindByName("CV-74 Stennis"), "Stennis Rescue Helo")
RescueheloStennis:SetTakeoffAir()
RescueheloStennis:SetRescueOff()
RescueheloStennis:Start()]]--

-- AirbasePolice-- 
AirbasePoliceCaucasus = ATC_GROUND_PERSIANGULF:New() 
--REMEMBER to Install Ciribob Slot Blocker for kicking --


-- Handle Blue AWACS and Tankers in OEO Using MOOSE --

function ARCO()
  ARCOSpawner = SPAWN:New("ARCO")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  --:InitRepeatOnLanding()
  :InitCleanUp(10)
  
 end
 
function SHELL()
  SHELLSpawner = SPAWN:New("SHELL")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  --:InitRepeatOnLanding()
  :InitCleanUp(10)
  
 end

function MAGIC()
  MAGICSpawner = SPAWN:New("MAGIC")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  --:InitRepeatOnLanding()
  :InitCleanUp(10)
  
 end
 
function DARKSTAR()
  DARKSTARSpawner = SPAWN:New("DARKSTAR")
  :InitLimit(1, 0)
  :SpawnScheduled(10, 0)
  --:InitRepeatOnLanding()
  :InitCleanUp(10)
  
end

function IranAWACS()
	IranAWACSSpawner = SPAWN:New("IranAWACS")
	:InitLimit(1, 0)
	:SpawnScheduled(10, 0)
	--:InitRepeatOnLanding()
	:InitCleanUp(10)

end
 
ARCO()
SHELL()
MAGIC()
DARKSTAR()
IranAWACS()

-- OEO Red Air Overhaul --

-- Define Jask Flights --

function JaskEastF5()
	JaskEastF5Spawner = SPAWN:NewWithAlias("JaskEastF5", "Jask Tiger A")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function JaskWestF5()
	JaskWestF5Spawner = SPAWN:NewWithAlias("JaskWestF5", "Jask Tiger B")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function JaskEastF4()
	JaskEastF4Spawner = SPAWN:NewWithAlias("JaskEastF4", "Jask Phantom A")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function JaskWestF4()
	JaskWestF4Spawner = SPAWN:NewWithAlias("JaskWestF4", "Jask Phantom B")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end


-- Define East Coast Flights --

function EastCoastMiG21()
	EastCoastMiG21Spawner = SPAWN:NewWithAlias("EastCoastMiG21", "East Coast Fishbed")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function EastCoastMiG29()
	EastCoastMiG29Spawner = SPAWN:NewWithAlias("EastCoastMiG29", "East Coast Fulcrum")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function EastCoastF4()
	EastCoastF4Spawner = SPAWN:NewWithAlias("EastCoastF4", "East Coast Phantom")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end


-- Define Qeshm East/Khasab Flights --

function QeshmEastMiG29A()
	QeshmEastMiG29ASpawner = SPAWN:NewWithAlias("QeshmEastMiG29A", "Qeshm East Fulcrum A")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function QeshmEastMiG29B()
	QeshmEastMiG29BSpawner = SPAWN:NewWithAlias("QeshmEastMiG29B", "Qeshm East Fulcrum B")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end


-- Define Qeshm West Flights --

function QeshmWestMiG29A()
	QeshmWestMiG29ASpawner = SPAWN:NewWithAlias("QeshmWestMiG29A", "Qeshm West Fulcrum A")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function QeshmWestMiG29B()
	QeshmWestMiG29BSpawner = SPAWN:NewWithAlias("QeshmWestMiG29B", "Qeshm West Fulcrum B")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function QeshmWestMiG29C()
	QeshmWestMiG29CSpawner = SPAWN:NewWithAlias("QeshmWestMiG29C", "Qeshm West Fulcrum C")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end


-- Define Tomcat Flights --

function TomcatsA()
	TomcatsASpawner = SPAWN:NewWithAlias("IranTomcatA", "Iran Tomcat A")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function TomcatsB()
	TomcatsBSpawner = SPAWN:NewWithAlias("IranTomcatB", "Iran Tomcat B")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function TomcatsC()
	TomcatsCSpawner = SPAWN:NewWithAlias("IranTomcatC", "Iran Tomcat C")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function TomcatsD()
	TomcatsDSpawner = SPAWN:NewWithAlias("IranTomcatD", "Iran Tomcat D")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end


-- Define Islands Flights --

function IslandsMiG21A()
	IslandsMiG21ASpawner = SPAWN:NewWithAlias("IslandsMiG21A", "Island Fishbed A")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function IslandsMiG21B()
	IslandsMiG21BSpawner = SPAWN:NewWithAlias("IslandsMiG21B", "Island Fishbed B")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function IslandsMiG21C()
	IslandsMiG21CSpawner = SPAWN:NewWithAlias("IslandsMiG21C", "Island Fishbed C")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function IslandsMiG21D()
	IslandsMiG21DSpawner = SPAWN:NewWithAlias("IslandsMiG21D", "Island Fishbed D")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function IslandsMiG21E()
	IslandsMiG21ESpawner = SPAWN:NewWithAlias("IslandsMiG21E", "Island Fishbed E")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end

function IslandsMiG21F()
	IslandsMiG21FSpawner = SPAWN:NewWithAlias("IslandsMiG21F", "Island Fishbed F")
	:InitLimit(2, 0)
	:SpawnScheduled(720, 0.25)
	:InitRepeatOnLanding()
	
end


-- Create Random Spawns for Each Zone --

-- Islands --

local IslandDefences = math.random(1, 9)
local TigersOrFishbeds = math.random(1, 2)

if IslandDefences == 1 then

	IslandsMiG21E()
	
elseif IslandDefences == 2 then

	IslandsMiG21F()
	
elseif IslandDefences == 3 then

	IslandsMiG21A()
	IslandsMiG21C()
	
elseif IslandDefences == 4 then

	IslandsMiG21A()
	IslandsMiG21E()
	
elseif IslandDefences == 5 then

	IslandsMiG21B()
	IslandsMiG21E()
	
elseif IslandDefences == 6 then

	IslandsMiG21B()
	IslandsMiG21D()
	
elseif IslandDefences == 7 then

	IslandsMiG21F()
	IslandsMiG21C()
	
elseif IslandDefences == 8 then

	IslandsMiG21F()
	IslandsMiG21D()
	
elseif IslandDefences == 9 then

	IslandsMiG21E()
	IslandsMiG21F()
	
end


-- Tomcats --

local TomcatDefences = math.random(1, 4)

if TomcatDefences == 1 then

	TomcatsA()
	TomcatsC()
	
elseif TomcatDefences == 2 then

	TomcatsB()
	TomcatsC()
	
elseif TomcatDefences == 3 then

	TomcatsB()
	TomcatsD()
	
elseif TomcatDefences == 4 then

	TomcatsA()
	TomcatsD()
	
end


-- Qeshm East/Khasab --

local QeshmEastAirDefences = math.random(1, 2)

if QeshmEastAirDefences == 1 then

	QeshmEastMiG29A()
	
elseif QeshmEastAirDefences == 2 then

	QeshmEastMiG29B()
	
end


-- Qeshm West --

local QeshmWestAirDefences = math.random(1, 3)

if QeshmWestAirDefences == 1 then

	QeshmWestMiG29A()
	
elseif QeshmWestAirDefences == 2 then

	QeshmWestMiG29B()
	
elseif QeshmWestAirDefences == 3 then

	QeshmWestMiG29C()
	
end


-- East Coast --

local EastCoastAirDefences = math.random(1, 3)

if EastCoastAirDefences == 1 then

	EastCoastMiG29()
	
elseif EastCoastAirDefences == 2 then

	EastCoastF4()
	
elseif EastCoastAirDefences == 3 then

	EastCoastMiG21()
	
end


-- Jask --

local JaskAirDefences = math.random(1, 2)

if JaskAirDefences == 1 then
	
	JaskWestF5()
	JaskEastF5()

elseif JaskAirDefences == 2 then
	
	JaskWestF4()
	JaskEastF4()
	
end



-- LIVES SYSTEM --

-- Define Required Variables and Functions --
LivesRemaining = 500
LivesAirborne = 0
LivesLost = 0
LivesMIA = 0
LivesAWOL = 0
Takeoff = {}
Landing = {}
Death = {}
Eject = {}
Disconnect = {}
--Revived = {}
MissionFailure = {}

-- Define Useful Functions for Amending Variable Values --

function PlayerTakeoff()
	LivesRemaining = LivesRemaining - 1
	LivesAirborne = LivesAirborne + 1
		if LivesRemaining < 0
			then
				LivesRemaining = 0
		end
end

function PlayerLand()
	LivesRemaining = LivesRemaining + 1
	LivesAirborne = LivesAirborne - 1
		if LivesAirborne < 0
			then
				LivesAirborne = 0
		end
end

function PlayerDie()
	LivesAirborne = LivesAirborne - 1
	LivesLost = LivesLost + 1
	if LivesLost < 0
		then
			LivesLost = 0
	end
end

function PlayerMIA()
	LivesMIA = LivesMIA + 1
	LivesAirborne = LivesAirborne - 1
		if LivesAirborne < 0
			then
				LivesAirborne = 0
		end
end

function PlayerRecovered()
	LivesLost = LivesLost - 1
	LivesRemaining = LivesRemaining + 1
		if
			LivesLost < 0
				then
					LivesLost = 0
		end
end

function PlayerAWOL()
	LivesAirborne = LivesAirborne - 1
	LivesAWOL = LivesAWOL + 1
		if LivesAirborne < 0
			then
				LivesAirborne = 0
		end
end

function PlayerNotAWOL()
	LivesAWOL = LivesAWOL - 1
	LivesAirborne = LivesAirborne + 1
		if LivesAWOL < 0
			then
				LivesAWOL = 0
		end
end
	
-- F10 Menu Check Remaning Lives --

function PrintLives()
	trigger.action.outTextForCoalition(2, "Operation Enduring Odyssey Lives Status \n\nLives Remaining: " ..LivesRemaining.. " \nAirborne Pilots: " ..LivesAirborne.. "\nPilots MIA: " ..LivesMIA.. "\nLives Lost: " ..LivesLost, 10, 1)
end

function F10CheckLives()
	local PrintLivesToPlayer = missionCommands.addCommandForCoalition(2, "Team Lives Status", nil, PrintLives, {})
end

F10CheckLives()

-- Define Actions on Player Events --

function Takeoff:onEvent(event)
	if (event.id == 3 and event.place:getTypeName() == "Al Minhad AB" and event.initiator:getPlayerName() ~= nil) or (event.id == 3 and event.place:getTypeName() == "Al Dhafra AB" and event.initiator:getPlayerName() ~= nil) or 
	(event.id == 3 and event.place:getTypeName() == "Stennis - airbase" and event.initiator:getPlayerName() ~= nil) or (event.id == 3 and event.place:getTypeName() == "LHA_Tarawa - airbase" and event.initiator:getPlayerName() ~= nil)
		then
			PlayerTakeoff()
			local DepartedPilot = event.initiator
			trigger.action.outTextForGroup(DepartedPilot:getGroup():getID(), "You have taken off and a life has been removed from the team. Land safely at either Al Dhafra, Al Minhad or the Carrier to return your life to the pool. Good luck!", 10, 1)
			--env.info("TAKEOFF EVENT RUN")
	elseif event.id == 3 and event.initiator:getPlayerName() ~= nil
		then
			PlayerNotAWOL()
			local NotAWOLPilot = event.initiator
			trigger.action.outTextForGroup(NotAWOLPilot:getGroup():getID(), "You have taken off again and are no longer considered AWOL. Return to Al Dhafra, Al Minhad or the Carrier to return your life to the pool.", 30, 1)
		end
end

function Landing:onEvent(event)
	if (event.id == 4 and event.place:getTypeName() == "Al Minhad AB" and event.initiator:getPlayerName() ~= nil) or (event.id == 4 and event.place:getTypeName() == "Al Dhafra AB" and event.initiator:getPlayerName() ~= nil) or 
	(event.id == 4 and event.place:getTypeName() == "Stennis - airbase" and event.initiator:getPlayerName() ~= nil) or (event.id == 3 and event.place:getTypeName() == "LHA_Tarawa - airbase" and event.initiator:getPlayerName() ~= nil)
		then 
			--env.info("LANDING DETECTED")
			local LandedPilot = event.initiator
			timer.scheduleFunction(LandingLifeCheck, LandedPilot, timer.getTime()+1)
			--env.info("SCHEDULED CHECK FUNCTION")
	elseif event.id == 4 and event.initiator:getPlayerName() ~= nil
		then
			--env.info("LANDING AT WRONG AIRBASE DETECTED")
			local LandedPilot = event.initiator
			timer.scheduleFunction(AWOLLandingLifeCheck, LandedPilot, timer.getTime()+1)
			--env.info("SCHEDULED AWOL CHECK FUNCTION")
	end
end

function LandingLifeCheck(PilotOnGround)
	--env.info("RUNNING LIFE CHECK")
	local PilotsLife = PilotOnGround:getLife()
	--env.info(PilotsLife)
		if PilotsLife > 0
			then
				--env.info("PLAYER IS ALIVE")
				PlayerLand()
				trigger.action.outTextForGroup(PilotOnGround:getGroup():getID(), "Welcome back! You have landed safely and your life has been returned to the team. Great job!", 10, 1)
				--env.info("LANDING EVENT RUN")
			end
end
		
function AWOLLandingLifeCheck(PilotOnGround)
	--env.info("RUNNING AWOL LIFE CHECK")
	local PilotsLife = PilotOnGround:getLife()
	--env.info(PilotsLife)
		if PilotsLife > 0
			then
				--env.info("PLAYER IS AWOL")
				PlayerAWOL()
				trigger.action.outTextForGroup(PilotOnGround:getGroup():getID(), "You have successfully landed, but at the wrong airbase! You are currently considered AWOL. Return to either Al Dhafra, Al Minhad or the Carrier to return your life to the pool.", 30, 1)
				--env.info("AWOL EVENT RUN")
			end
end
		
function Death:onEvent(event)
	if event.id == 9 and event.initiator:getPlayerName() ~= nil
		then
			PlayerDie()
			local KilledPilot = event.initiator
			trigger.action.outTextForGroup(KilledPilot:getGroup():getID(), "You have been killed in action. Your life has been added to the death toll. Be more careful next time!", 10, 1)
			--env.info("DEATH EVENT RUN")
		end
end

function Eject:onEvent(event)
	if event.id == 6 and event.initiator:getPlayerName() ~= nil
		then
			PlayerMIA()
			local EjectedPilot = event.initiator
			--trigger.action.outTextForCoalition(2, EjectedPilot:getPlayerName().." has ejected safely and a CSAR mission is available to rescue them! Use the F10 Menu for more information. (STILL INACTIVE)", 10, 1) -- This line will be removed as Ali's CSAR Script sends the CSAR message.
			--env.info("EJECT EVENT RUN")
		end
end

--[[function Revived:onEvent(event) --ALI ASSURES ME HE WILL DEAL WITH THIS IN HIS CSAR SCRIPT.wav
	if (CSAR Script Mission complete = true)
		then
			PlayerRecovered()
			trigger.action.outTextForGroup(RECOVERYPILOTSNAME, "You have successfully returned a downed pilot to base, and a life has been added to the pool. Great job!", 10, 1)
			--env.info("RECOVERY EVENT RUN")
		end
end]]--

function Disconnect:onEvent(event)
	if event.id == 20 and event.initiator:inAir() == true
		then
			PlayerDie()
			--env.info("DISCONNECT EVENT RUN")
		end
end

-- Define Function for actioning Mission Failure --

function RestartMission()
	net.load_next_mission()
end

function MissionFailure:onEvent(event)
	if event.id == 9 and event.initiator:getPlayerName() ~= nil and LivesLost > 500
		then
			trigger.action.outTextForCoalition(2, "The death toll of Operation Enduring Odyssey has soared too high. Public opinion of the Operation has fallen and units are being pulled out of the Persian Gulf. Mission Failed.", 60, 1)
			timer.scheduleFunction(RestartMission, {}, timer.getTime()+60)
		end
end

world.addEventHandler(Takeoff)
world.addEventHandler(Landing)
world.addEventHandler(Death)
world.addEventHandler(Eject)
--world.addEventHandler(Revived)
world.addEventHandler(MissionFailure)
world.addEventHandler(Disconnect)









-- DYNAMIC COMBAT SEARCH AND RESCUE --

local SpawnDownedPilot = SPAWN:New("DownedPilot")
NumberCSARMissions = 0
CSARPilotsOnBoard = {}
NewCSARMission = {}
CSARDropoff = {}
ActiveCSARFrequences = {}

function NewCSARMission:onEvent(event)
	if event.id == 6 and event.initiator:getPlayerName() ~= nil
		then
			NumberCSARMissions = NumberCSARMissions + 1  
			local EjectedPlayer = event.initiator
			local EjectedPlayerVec3 = EjectedPlayer:getPoint()
			local EjectedPlayerCoordinate = COORDINATE:NewFromVec3(EjectedPlayerVec3)
			local NearestRoad = EjectedPlayerCoordinate:GetClosestPointToRoad()
			local NearestRoadVec2 = NearestRoad:GetVec2() 
			local SpawnedPilot = SpawnDownedPilot:SpawnFromVec2(NearestRoadVec2)
			local SpawnedPilotPosition = SpawnedPilot:GetVec3()
			local PilotFrequency = math.random(45, 69)  
			local FreqForMessage = PilotFrequency
			PilotFrequency = PilotFrequency*1000000
			local setFrequency = { 
				id = 'SetFrequency', 
				params = {
					frequency = PilotFrequency,
					modulation = radio.modulation.FM, 
				} 
			}
			local DownedPilot = Group.getByName('DownedPilot#00' ..NumberCSARMissions)
			local DownedPilotUnit = DownedPilot:getUnit(1)
			local DownedPilotPos = DownedPilotUnit:getPoint()
			local DownedPilotController = Group.getController(DownedPilot)
			DownedPilotController:setCommand(setFrequency)
			trigger.action.outTextForCoalition(2, EjectedPlayer:getPlayerName().." has been hit and is going down! Initial reports suggest a good chute, and a CSAR mission is being readied to rescue him. Use the F10 menu for more information.", 20, 1)
			trigger.action.outTextForCoalition(2, "ADF Beacon on " ..FreqForMessage.. ".00 mHz FM", 20, 1)
			local foundObjects = {}
			timer.scheduleFunction(CSARAreaSearch, {DownedPilotUnit, foundObjects, DownedPilot}, timer.getTime()+ 10)
		end
end

function CSARAreaSearch(ParamTable)
	env.info("Entered Search Function")
	local Pilot = ParamTable[1]
	local foundObjects = ParamTable[2]
	local PilotPosition = Pilot:getPoint()
	local PilotGroup = ParamTable[3]
	local CSARSearchZone = {
		id = world.VolumeType.SPHERE,
		params = {
			point = PilotPosition,
			radius = 100
			}
		}
	world.searchObjects(Object.Category.UNIT, CSARSearchZone, ifFoundUnit, foundObjects)
	env.info(#foundObjects)
	if #foundObjects >= 1
		then
			foundObjectsName = foundObjects[1]
			trigger.action.outTextForCoalition(2, "You have successfully picked up the pilot! Get him back to the nearest airbase or FARP to complete the CSAR mission!", 20, 1)
			trigger.action.deactivateGroup(PilotGroup)
			PlayerCSARCount = trigger.misc.getUserFlag(foundObjectsName.."CSARCount")
			env.info("FLAG SET TO" ..PlayerCSARCount)
				if PlayerCSARCount < 1
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 1)
						trigger.action.outTextForGroup(foundObjectsName, "Pilots on board: 1/4", 20, 1)
				elseif PlayerCSARCount == 1
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 2)
						trigger.action.outTextForGroup(foundObjectsName, "Pilots on board: 2/4", 20, 1)
				elseif PlayerCSARCount == 2
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 3)
						trigger.action.outTextForGroup(foundObjectsName, "Pilots on board: 3/4", 20, 1)
				elseif PlayerCSARCount == 3
					then
						trigger.action.setUserFlag(foundObjectsName.."CSARCount", 4)
						trigger.action.outTextForGroup(foundObjectsName, "Your heli is now full! Return to the nearest airbase or FARP to drop the pilots off and complete the CSAR missions!", 20, 1)
				elseif PlayerCSARCount > 3
					then
						trigger.action.outTextForGroup(foundObjectsName, "Your heli is already full! You must return to base before collecting any more pilots!", 20, 1)
				end
		else
			--trigger.action.outTextForCoalition(2, "DIDNT FIND ANYTHING", 20, 1)
			return timer.getTime() + 30
	end
end

function ifFoundUnit(foundItem, val)
	if foundItem:hasAttribute("Helicopters") and foundItem:getPlayerName() ~= nil and foundItem:inAir() == false
		then
			val[#val + 1] = foundItem:getGroup():getID()
	end
end

function CSARDropoff:onEvent(event)
	if event.id == 4 and event.initiator:getPlayerName() ~= nil
		then
			CheckCSARonBoard = trigger.misc.getUserFlag(event.initiator:getGroup():getID().."CSARCount")
				if CheckCSARonBoard > 0
					then
						LivesRemaining = LivesRemaining + CheckCSARonBoard
						CheckCSARonBoard = 0
						trigger.action.setUserFlag(event.initiator:getGroup():getID().."CSARCount", 0)
						trigger.action.outTextForGroup(event.initiator:getGroup():getID(), "You have successfully returned the downed Pilot to base! His life has been returned to the pool!", 30, 1)
				end
	end
end

world.addEventHandler(NewCSARMission)
world.addEventHandler(CSARDropoff)









-- SEAD AND WEAPON DAMAGE IMPROVEMENT SCRIPT --

local tracked_weapons = {}
shotHandler = {}
local function getDistance (point1, point2)

  --  env.info("Calculating Distance")
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
  --  suppUnit:GetGroup():setOption(9, 2) --radar on  
  --  env.warning("Unit " ..suppUnit:getName().. " has turned radar back on", false)

end
local function startSuppressionMag(suppUnit)

  suppUnit:getGroup():getController():setOnOff(false)
  --  suppUnit:GetGroup():setOption(9, 1) --radar off  
  --  env.info("Unit ".. suppUnit:getID().. " has turned radar off")
  timer.scheduleFunction(recoverSuppresionMag, suppUnit, timer.getTime() + math.random(20,60))

end
local function recoverSuppresion(suppUnit, time)
  suppUnit:getController():setOnOff(true)
  env.warning("Unit " ..suppUnit:getName().. "has recovered from suppression.", false)
  return nil
end
local function ifFoundMag(foundItem, val)

  -- env.info("Search found groupID: " ..foundItem:getName())
  coalition = foundItem:getCoalition()
  -- env.info("It is part of Coalition " ..coalition)

  if coalition == 2 then
  --    env.info("Group is friendly - Ignored")

  else 
    --   env.info("Group is not friendly - Continue")

    if foundItem:hasAttribute("SAM SR") then

      --      env.info(foundItem:getName().. " is a SAM SR")              
      if math.random(1,100) > 25 then

        --        env.info("Oh shit turn the radars off, said Ahmed, working at "..foundItem:getName()) 
        timer.scheduleFunction(startSuppressionMag, foundItem, timer.getTime() + math.random(5,15))

      end   
    end 
  end      
end
local function ifFoundK(foundItem, impactPoint)
  env.info("Found unit to kill in radius")
  local groupFound = foundItem:getGroup()
  if groupFound:getCategory() == 2 then
    local point1 = foundItem:getPoint()
    point1.y = point1.y + 2
    local point2 = impactPoint
    point2.y = point2.y + 2
    if land.isVisible(point1, point2) == true then
      env.info("killed")
      trigger.action.explosion(point1, 1)

    end
  end                                                                    
end
local function ifFoundKS(foundItem, impactPoint)
  env.info("Found static to kill in radius")
  local point1 = foundItem:getPoint()
  env.info("found static pos")
  point1.y = point1.y + 2
  local point2 = impactPoint
  point2.y = point2.y + 2
  if land.isVisible(point1, point2) == true then
    trigger.action.explosion(point1, 10)
    env.info("killed")
    

  end

end
local function ifFoundS(foundItem, impactPoint)
  env.info("Found unit to suppress in radius")
  local groupFound = foundItem:getGroup()
  if groupFound:getCategory() == 2 then
    local point1 = foundItem:getPoint()
    point1.y = point1.y + 2
    local point2 = impactPoint
    point2.y = point2.y + 2
    if land.isVisible(point1, point2) == true then
      foundItem:getGroup():getController():setOnOff(false)
      timer.scheduleFunction(recoverSuppresion, foundItem, time + math.random(35,120))
       env.info("suppressed")
      

    end
  end                                                                    
end

function shotHandler:onEvent(event)
  if event.id == world.event.S_EVENT_SHOT 
  then
    if event.weapon then

      env.info("weapon launched")          
      local ordnance = event.weapon                  
      local ordnanceName = ordnance:getTypeName()
      local WeaponPos = ordnance:getPosition().p
      local WeaponDir = ordnance:getPosition().x  
      local init = event.initiator
      local init_name = ' '
      if ordnanceName == "weapons.missiles.AGM_122" or ordnanceName == "weapons.missiles.AGM_88" or ordnanceName == "weapons.missiles.LD-10" then
        env.info("of type ARM") 
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
        env.warning("Begin Search for all magnum changes")
        world.searchObjects(Object.Category.UNIT, VolMag, ifFoundMag) 
        env.warning("Finished Search for all magnum changes")  
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
      --                env.info("Mass of weapon warhead is " .. wpnData.exMass)
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


      env.warning("Begin Search", false)
      world.searchObjects(Object.Category.UNIT, VolK, ifFoundK,impactPoint)
      world.searchObjects(Object.Category.UNIT, VolS, ifFoundS,impactPoint)
      world.searchObjects(Object.Category.STATIC, VolKS, ifFoundKS,impactPoint)       

      tracked_weapons[wpn_id_] = nil -- remove from tracked weapons first.         

    end
  end
  return time + timeInterval
end

timer.scheduleFunction(track_wpns, .5, timer.getTime() + 1)

