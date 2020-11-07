-- OEO Proportional Red Air Response --

-- Define Required Variables --

local redVariationValue = 1 --math.random(1, 4)

local initPictureComplete = false

local function runwayActive(name)
	if trigger.misc.getUserFlag(name) == nil or trigger.misc.getUserFlag(name) == 0 then
		return true
	else
		return false
	end
end

-- Define Flights Using MOOSE --

-- ISLANDS --

local function VarAIsl21()
		VarAIsl21 = SPAWN:New("VarAIsl21")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBIsl21()
		VarBIsl21 = SPAWN:New("VarBIsl21")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarAIslF5()
		VarAIslF5 = SPAWN:New("VarAIslF5")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBIslF5()
		VarBIslF5 = SPAWN:New("VarBIslF5")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function VarAIsl22()
		VarAIsl22 = SPAWN:New("VarAIsl22")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function VarBIsl22()
		VarBIsl22 = SPAWN:New("VarBIsl22")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function ScrambleIslandsF5()
	ScrambleIslandsF5 = SPAWN:New("ScrambleIslandsF5")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

local function ScrambleIslands21()
	ScrambleIslands21 = SPAWN:New("ScrambleIslands21")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

local function ScrambleIslands22()
	ScrambleIslands22 = SPAWN:New("ScrambleIslands22")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

-- JASK --

local function VarAJask21()
		VarAJask21 = SPAWN:New("VarAJask21")
		:InitLimit(2, 30)
		:InitDelayOn()
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBJask21()
		VarBJask21 = SPAWN:New("VarBJask21")
		:InitLimit(2, 30)
		:InitDelayOn()
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function VarAJask22()
		VarAJask22 = SPAWN:New("VarAJask22")
		:InitLimit(2, 30)
		:InitDelayOn()
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBJask22()
		VarBJask22 = SPAWN:New("VarBJask22")
		:InitLimit(2, 30)
		:InitDelayOn()
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarAJaskF5()
		VarAJaskF5 = SPAWN:New("VarAJaskF5")
		:InitLimit(2, 30)
		:InitDelayOn()
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBJaskF5()
		VarBJaskF5 = SPAWN:New("VarBJaskF5")
		:InitLimit(2, 30)
		:InitDelayOn()
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

-- QESHM/KHASAB --

local function VarAQWF4()
		VarAQWF4 = SPAWN:New("VarAQWF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBQWF4()
		VarBQWF4 = SPAWN:New("VarBQWF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
		
local function VarAQEF4()
		VarAQWE4 = SPAWN:New("VarAQEF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBQEF4()
		VarBQWE4 = SPAWN:New("VarBQEF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function ScrambleKhasabF4()
	ScrambleKhasabF4 = SPAWN:New("ScrambleKhasabF4")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end


local function VarAQW23()
		VarAQW23 = SPAWN:New("VarAQW23")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBQW23()
		VarBQW23 = SPAWN:New("VarBQW23")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
		
local function VarAQE23()
		VarAQWE4 = SPAWN:New("VarAQE23")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBQE23()
		VarBQWE4 = SPAWN:New("VarBQE23")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function ScrambleKhasab23()
	ScrambleKhasab23 = SPAWN:New("ScrambleKhasab23")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

-- MAINLAND NORTH --

local function TomcatsA()
		TomcatsASpawner = SPAWN:NewWithAlias("IranTomcatA", "Iran Tomcat A")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.1)
		:InitRepeatOnLanding()	
end
	
local function TomcatsB()
		TomcatsBSpawner = SPAWN:NewWithAlias("IranTomcatB", "Iran Tomcat B")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.1)
		:InitRepeatOnLanding()		
end
	
local function TomcatsC()
		TomcatsCSpawner = SPAWN:NewWithAlias("IranTomcatC", "Iran Tomcat C")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.1)
		:InitRepeatOnLanding()		
end
	
local function TomcatsD()
		TomcatsDSpawner = SPAWN:NewWithAlias("IranTomcatD", "Iran Tomcat D")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.1)
		:InitRepeatOnLanding()		
end
	
-- MAINLAND SOUTH --
	
local function InlandFulcrumsA()
		InlandFulcrumsA = SPAWN:New("InlandFulcrumsA")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function InlandFulcrumsB()
		InlandFulcrumsB = SPAWN:New("InlandFulcrumsB")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function InlandFulcrumsC()
		InlandFulcrumsC = SPAWN:New("InlandFulcrumsC")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function InlandFulcrumsD()
	InlandFulcrumsD = SPAWN:New("InlandFulcrumsD")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end


-- Individual Airbase Controllers --

local function JaskControl(thrt)

	if initPictureComplete == false then

		if 	redVariationValue == 1 then
			VarAJask22()
			VarBJask22()
		elseif redVariationValue == 2 then
			VarAJask21()
			VarBJask21()
		else
			VarAJaskF5()
			VarBJaskF5()
		end
		
		initPictureComplete = true
	end
		
	if runwayActive("Jask") == false then
	
		env.info("Jask's runway is fucked! Stopping flights for 1 hr...")
		
		if 	redVariationValue == 1 then
			VarAJask22:spawnScheduleStop()
			VarBJask22:spawnScheduleStop()
		elseif redVariationValue == 2 then
			VarAJask21:spawnScheduleStop()
			VarBJask21:spawnScheduleStop()
		else
			VarAJaskF5:spawnScheduleStop()
			VarBJaskF5:spawnScheduleStop()
		end
	else
	
		env.info("Jask's runway is fine! Resuming flight operations.")
		
		if 	redVariationValue == 1 then
			VarAJask22:spawnScheduleStart()
			VarBJask22:spawnScheduleStart()
		elseif redVariationValue == 2 then
			VarAJask21:spawnScheduleStart()
			VarBJask21:spawnScheduleStart()
		else
			VarAJaskF5:spawnScheduleStart()
			VarBJaskF5:spawnScheduleStart()
		end
	end
end

--[[local function AbbasControl(thrt)

	if initPictureComplete == false then

		if 	redVariationValue == 1 then
			VarAQWF4()
			VarAQEF4()
		elseif redVariationValue == 2 then
			VarBQWF4()
			VarBQEF4()
		elseif redVariationValue == 3 then
			VarAQW23()
			VarAQE23()
		else
			VarBQW23()
			VarBQE23()
		end
			initPictureComplete = true
		end
		
	if runwayActive("BandarAbbas_03L") == false and runwayActive("BandarAbbas_03R") == false then -- disables or re-enablers all spawns based on Runways being fucked or not
		if 	redVariationValue == 1 then
			VarAQWF4:spawnScheduleStop()
			VarAQEF4:spawnScheduleStop()
		elseif redVariationValue == 2 then
			VarBQWF4:spawnScheduleStop()
			VarBQEF4:spawnScheduleStop()
		elseif redVariationValue == 3 then
			VarAQW23:spawnScheduleStop()
			VarAQE23:spawnScheduleStop()
		else
			VarBQW23:spawnScheduleStop()
			VarBQE23:spawnScheduleStop()
		end
	else
		if 	redVariationValue == 1 then
			VarAQWF4:spawnScheduleStart()
			VarAQEF4:spawnScheduleStart()
		elseif redVariationValue == 2 then
			VarBQWF4:spawnScheduleStart()
			VarBQEF4:spawnScheduleStart()
		elseif redVariationValue == 3 then
			VarAQW23:spawnScheduleStart()
			VarAQE23:spawnScheduleStart()
		else
			VarBQW23:spawnScheduleStart()
			VarBQE23:spawnScheduleStart()
		end
	end
end]]--


-- Analysis Functions --

local function airThreatCalc() 	-- Calculates Threat Level posed by Blue Fighters on Server --

	local fighterValue = 0
	local strikerValue = 0
	local airThreatValue = 0
	local airThreatLevel = 0
		
	local playerTable = {}
	playerTable = coalition.getPlayers(2)
		
	if #playerTable < 1 then
	
		airThreatValue = 0
		
	else
		for i = 1, #playerTable do
		
			if	playerTable[i]:getTypeName() == "A-10A" 	or
				playerTable[i]:getTypeName() == "A-10C" 	or
				playerTable[i]:getTypeName() == "A-10C-2"	or
				playerTable[i]:getTypeName() == "AV-8B" 	or
				playerTable[i]:getTypeName() == "AJS37" 	or
				playerTable[i]:getTypeName() == "SU-25T" 	or
				playerTable[i]:getTypeName() == "F-5E-3" 	or
				playerTable[i]:getTypeName() == "MiG-21Bis" then
				
				strikerValue = strikerValue + 1
				
			else
				
				fighterValue = fighterValue + 1
				
			end
		end
			
		airThreatValue = (strikerValue / 2) + fighterValue
		
	end
					
		if airThreatValue <= 5 then
		
			airThreatLevel = 0
			
		elseif airThreatValue > 5 and airThreatValue <= 12 then
		
			airThreatLevel = 1
			
		elseif airThreatValue > 12 and airThreatValue <= 20 then
		
			airThreatLevel = 2
		
		elseif airThreatValue > 20 then
		
			airThreatLevel = 3
			
		end
		
	return airThreatLevel
	
end



local function pictureUpdate() 	-- Check Blue Air Player Assets and Schedule a Response Accordingly --

	env.info("PROP-AIR: Check Blue Air Function started!")
	if initPictureComplete == false then
		env.info("No state detected, initiating...")
	end

	local airThreat = airThreatCalc()
	
	JaskControl(airThreat)
	AbbasControl(airThreat)	
		
	env.info("PROP-AIR: Check Blue Air Function finished!")
	return timer.getTime() + 10
end

-- Initiate checkBlueAir Schedule --

local function redAirInit()

	env.info("PROP-AIR: Initiated!")
	timer.scheduleFunction(pictureUpdate, nil, timer.getTime() + 1)

end

redAirInit()