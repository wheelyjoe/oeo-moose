-- OEO Proportional Red Air Response --

-- Define Required Variables --

local redVariationValue = math.random(1, 6)

local initPictureComplete = false

local strikerTypes = {	"A-10A",
						"A-10C",
						"AV-8B",
						"AJS37",
						"SU-25T",
						"F-5E-3",
						"MiG-21Bis"
}

local fighterTypes = {	"F-14B",
						"F-15C",
						"F-16CM bl.50",
						"F/A-18C Lot 20",
						"M-2000C",
						"JF-17",
						"MiG-29S",
						"Su-27"
}

-- Define Flights Using MOOSE --

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
	
local function VarAIslF4()
		VarAIslF4 = SPAWN:New("VarAIslF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBIslF4()
		VarBIslF4 = SPAWN:New("VarBIslF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
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
	
local function VarAJaskF4()
		VarAJaskF4 = SPAWN:New("VarAJaskF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBJaskF4()
		VarBJaskF4 = SPAWN:New("VarBJaskF4")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

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
	
local function VarAQW29()
		VarAQW29 = SPAWN:New("VarAQW29")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBQW29()
		VarBQW29 = SPAWN:New("VarBQW29")
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

local function VarAQE29()
		VarAQE29 = SPAWN:New("VarAQE29")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end
	
local function VarBQE29()
		VarBQE29 = SPAWN:New("VarBQE29")
		:InitLimit(2, 30)
		:SpawnScheduled(1800, 0.25)
		:InitRepeatOnLanding()
end

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

local function VariationA()

	env.info("Entered Spawning Function A")

	if initPictureComplete == false then
		
		VarAIsl21()
		VarAJask21()
		VarAQWF4()
		VarAQEF4()
		InlandFulcrumsA()
		InlandFulcrumsC()
		
		env.info("PROP-AIR: Variation A default state initiated.")
		initPictureComplete = true
	end

	-- if threat > X etc.
	
end

local function VariationB()

	env.info("Entered Spawning Function B")

	if initPictureComplete == false then
	
		VarBIsl21()
		VarBJask21()
		VarBQWF4()
		VarBQEF4()
		InlandFulcrumsB()
		InlandFulcrumsD()
	
		env.info("PROP-AIR: Variation B default state initiated.")
		initPictureComplete = true
	end
	
	-- if threat > X etc.

end

local function VariationC()

	env.info("Entered Spawning Function C")

	if initPictureComplete == false then
	
		VarAIsl21()
		VarAJaskF4()
		VarAQW29()
		VarAQE29()
		TomcatsA()
		TomcatsC()
	
		env.info("PROP-AIR: Variation C default state initiated.")
		initPictureComplete = true
	end
	
	-- if threat > X etc.

end

local function VariationD()

	env.info("Entered Spawning Function D")

	if initPictureComplete == false then
	
		VarBIsl21()
		VarBJaskF4()
		VarBQW29()
		VarBQE29()
		TomcatsA()
		TomcatsD()
		
		env.info("PROP-AIR: Variation D default state initiated.")
		initPictureComplete = true
	end
	
	-- if threat > X etc.

end

local function VariationE()

	env.info("Entered Spawning Function E")

	if initPictureComplete == false then
	
		VarAIslF4()
		VarBJask21()
		VarBQW29()
		VarAQE29()
		TomcatsB()
		TomcatsD()
	
		env.info("PROP-AIR: Variation E default state initiated.")
		initPictureComplete = true
	end
	
	-- if threat > X etc.

end

local function VariationF()

	env.info("Entered Spawning Function F")

	if initPictureComplete == false then
	
		VarBIslF4()
		VarAJask21()
		VarAQW29()
		VarBQe29()
		TomcatsB()
		TomcatsC()
		
		env.info("PROP-AIR: Variation F default state initiated.")
		initPictureComplete = true
	end
	
	-- if threat > X etc.

end

-- Check Blue Air Player Assets and Schedule a Response Accordingly --

local function checkBlueAir()

	env.info("PROP-AIR: Check Blue Air Function started!")

	local fighterValue = 0
	local strikerValue = 0
	local airThreatValue = 0
	
	local playerTable = {}
	playerTable = coalition.getPlayers(2)
	
	if #playerTable < 1 then
	
		airThreatValue = 0
		
	else
		for i = 1, #playerTable do
			if strikerTypes[playerTable[i].getTypeName()] == true then
			strikerValue = strikerValue + 1
				
			elseif fighterTypes[playerTable[i].getTypeName()] == true then
			fighterValue = fighterValue + 1
			
			else
			env.info("PROP-AIR WARNING: Type "..playerTable[i].getTypeName().." not accounted for!")
			
			end
		end					
		
		airThreatValue = (strikerValue / 2) + fighterValue
		
	end
	
	if airThreatValue < 0 then 
		
		airThreatValue = 0
	
	end
		
	if redVariationValue == 1 then
	
		VariationA()
	
	elseif redVariationValue == 2 then
	
		VariationB()
		
	elseif redVariationValue == 3 then
	
		VariationC()
		
	elseif redVariationValue == 4 then
	
		VariationD()
		
	elseif redVariationValue == 5 then
	
		VariationE()
	
	elseif redVariationValue == 6 then
	
		VariationF()
	
	end
	
	env.info("PROP-AIR: Check Blue Air Function finished!")
	return timer.getTime() + 600
	
end

-- Initiate checkBlueAir Schedule --

local function redAirInit()

	env.info("PROP-AIR: Initiated!")
	timer.scheduleFunction(checkBlueAir, nil, timer.getTime() + 1)

end

redAirInit()