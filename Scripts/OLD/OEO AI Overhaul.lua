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