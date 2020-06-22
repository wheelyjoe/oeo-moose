-- OEO Proportional Red Air Response --

-- Define Required Variables --

local redVariationValue = math.random(1, 3)

local initPictureComplete = false

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
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBJask21()
		VarBJask21 = SPAWN:New("VarBJask21")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

local function VarAJask22()
		VarAJask22 = SPAWN:New("VarAJask22")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBJask22()
		VarBJask22 = SPAWN:New("VarBJask22")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarAJaskF5()
		VarAJaskF5 = SPAWN:New("VarAJaskF5")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBJaskF5()
		VarBJaskF5 = SPAWN:New("VarBJaskF5")
		:InitLimit(2, 30)
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

--Define Variations of Above Flights--

local function VariationA(threat)

	if initPictureComplete == false then
		
		InlandFulcrumsA()
		InlandFulcrumsB()
		InlandFulcrumsC()
		InlandFulcrumsD()
		TomcatsA()
		TomcatsB()
		TomcatsC()
		TomcatsD()
		
		VarAIsl21()
		VarBIsl21()
		
		VarAJask22()
		VarBJask22()
		
		VarAQWF4()
		VarAQEF4()
		
		ScrambleIslands21()
		ScrambleKhasabF4()
		
		env.info("PROP-AIR: Variation A default state initiated.")
		initPictureComplete = true
	end

	if threat == 3 then
		ScrambleKhasabF4:SpawnScheduleStart()
		ScrambleIslands21:SpawnScheduleStart()
	
	elseif threat == 2 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStart()	
		
	elseif threat == 1 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()

	else	
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
	end	
end

local function VariationB(threat)

	if initPictureComplete == false then
	
		InlandFulcrumsA()
		InlandFulcrumsB()
		InlandFulcrumsC()
		InlandFulcrumsD()
		TomcatsA()
		TomcatsB()
		TomcatsC()
		TomcatsD()
		
		VarAIsl22()
		VarBIsl22()
		
		VarAJaskF5()
		VarBJaskF5()
		
		
		VarBQWF4()
		VarBQEF4()
		
		ScrambleIslands22()
		ScrambleKhasabF4()
	
		env.info("PROP-AIR: Variation B default state initiated.")
		initPictureComplete = true
	end
	
	if threat == 3 then
		ScrambleKhasabF4:SpawnScheduleStart()
		ScrambleIslands22:SpawnScheduleStart()
		
	elseif threat == 2 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands22:SpawnScheduleStart()	
		
	elseif threat == 1 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands22:SpawnScheduleStop()

	else	
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands22:SpawnScheduleStop()
	end
end

local function VariationC(threat)

	if initPictureComplete == false then
	
		InlandFulcrumsA()
		InlandFulcrumsB()
		InlandFulcrumsC()
		InlandFulcrumsD()
		TomcatsA()
		TomcatsB()
		TomcatsC()
		TomcatsD()
		
		VarAIslF5()
		VarBIslF5()
		
		VarAJask21()
		VarBJask21()
		
		VarAQEF4()
		VarBQWF4()
		
		ScrambleIslandsF5()
		ScrambleKhasabF4()
	
		env.info("PROP-AIR: Variation C default state initiated.")
		initPictureComplete = true
	end
	
	if threat == 3 then
		ScrambleKhasabF4:SpawnScheduleStart()
		ScrambleIslandsF5:SpawnScheduleStart()
	
		
	elseif threat == 2 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslandsF5:SpawnScheduleStart()
	
	elseif threat == 1 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslandsF5:SpawnScheduleStop()

	else	
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslandsF5:SpawnScheduleStop()
	end
end


-- Check Blue Air Player Assets and Schedule a Response Accordingly --

local function checkBlueAir()

	env.info("PROP-AIR: Check Blue Air Function started!")

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
				
	if redVariationValue == 1 then
	
		VariationA(airThreatLevel)
	
	elseif redVariationValue == 2 then
	
		VariationB(airThreatLevel)
		
	elseif redVariationValue == 3 then
	
		VariationC(airThreatLevel)
		
	end
		
	env.info("PROP-AIR: Check Blue Air Function finished!")
	return timer.getTime() + 300
end

-- Initiate checkBlueAir Schedule --

local function redAirInit()

	env.info("PROP-AIR: Initiated!")
	timer.scheduleFunction(checkBlueAir, nil, timer.getTime() + 1)

end

redAirInit()