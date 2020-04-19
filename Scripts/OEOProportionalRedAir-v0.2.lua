-- OEO Proportional Red Air Response --

-- Define Required Variables --

local redVariationValue = math.random(1, 6)

local initPictureComplete = false

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

local function ScrambleIslandsF4()
	ScrambleIslandsF4 = SPAWN:New("ScrambleIslandsF4")
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

local function ScrambleJask21A()
	ScrambleJask21A = SPAWN:New("ScrambleJask21A")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

local function ScrambleJask21B()
	ScrambleJask21B = SPAWN:New("ScrambleJask21B")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

local function ScrambleJaskF4A()
	ScrambleJaskF4A = SPAWN:New("ScrambleJaskF4A")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

local function ScrambleJaskF4B()
	ScrambleJaskF4B = SPAWN:New("ScrambleJaskF4B")
	:InitLimit (2, 16)
	:InitDelayOn()
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

local function ScrambleKhasab29()
	ScrambleKhasab29 = SPAWN:New("ScrambleKhasab29")
	:InitLimit (2, 16)
	:InitDelayOn()
	:SpawnScheduled(1800, 0.25)
	:InitRepeatOnLanding()
end

--Define Variations of Above Flights--

local function VariationA(threat)

	if initPictureComplete == false then
		
		VarAIsl21()
		VarAJask21()
		VarAQWF4()
		VarAQEF4()
		InlandFulcrumsA()
		InlandFulcrumsC()
		ScrambleJask21B()
		ScrambleIslands21()
		ScrambleKhasabF4()
		
		env.info("PROP-AIR: Variation A default state initiated.")
		initPictureComplete = true
	end

	if threat == 3 then
		ScrambleKhasabF4:SpawnScheduleStart()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJask21B:SpawnScheduleStart()
	
		
	elseif threat == 2 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJask21B:SpawnScheduleStart()
	
		
	elseif threat == 1 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJask21B:SpawnScheduleStart()

	else	
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJask21B:SpawnScheduleStop()
	end	
end

local function VariationB(threat)

	if initPictureComplete == false then
	
		VarBIsl21()
		VarBJask21()
		VarBQWF4()
		VarBQEF4()
		InlandFulcrumsB()
		InlandFulcrumsD()
		ScrambleJask21A()
		ScrambleIslands21()
		ScrambleKhasabF4()
	
		env.info("PROP-AIR: Variation B default state initiated.")
		initPictureComplete = true
	end
	
	if threat == 3 then
		ScrambleKhasabF4:SpawnScheduleStart()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJask21A:SpawnScheduleStart()
	
		
	elseif threat == 2 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJask21A:SpawnScheduleStart()
	
		
	elseif threat == 1 then
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJask21A:SpawnScheduleStart()

	else	
		ScrambleKhasabF4:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJask21A:SpawnScheduleStop()
	end
end

local function VariationC(threat)

	if initPictureComplete == false then
	
		VarAIsl21()
		VarAJaskF4()
		VarAQW29()
		VarAQE29()
		TomcatsA()
		TomcatsC()
		ScrambleIslands21()
		ScrambleJaskF4B()
		ScrambleKhasab29()
	
		env.info("PROP-AIR: Variation C default state initiated.")
		initPictureComplete = true
	end
	
	if threat == 3 then
		ScrambleKhasab29:SpawnScheduleStart()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJaskF4B:SpawnScheduleStart()
	
		
	elseif threat == 2 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJaskF4B:SpawnScheduleStart()
	
		
	elseif threat == 1 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJaskF4B:SpawnScheduleStart()

	else	
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJaskF4B:SpawnScheduleStop()
	end
end

local function VariationD(threat)

	if initPictureComplete == false then
	
		VarBIsl21()
		VarBJaskF4()
		VarBQW29()
		VarBQE29()
		TomcatsA()
		TomcatsD()
		ScrambleIslands21()
		ScrambleJaskF4A()
		ScrambleKhasab29()
		
		env.info("PROP-AIR: Variation D default state initiated.")
		initPictureComplete = true
	end
	
	if threat == 3 then
		ScrambleKhasab29:SpawnScheduleStart()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJaskF4A:SpawnScheduleStart()
	
		
	elseif threat == 2 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStart()
		ScrambleJaskF4A:SpawnScheduleStart()
	
		
	elseif threat == 1 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJaskF4A:SpawnScheduleStart()

	else	
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslands21:SpawnScheduleStop()
		ScrambleJaskF4A:SpawnScheduleStop()
	end
end

local function VariationE(threat)

	env.info("Entered Spawning Function E")

	if initPictureComplete == false then
	
		VarAIslF4()
		VarBJask21()
		VarBQW29()
		VarAQE29()
		TomcatsB()
		TomcatsD()
		ScrambleIslandsF4()
		ScrambleJask21A()
		ScrambleKhasab29()
	
		env.info("PROP-AIR: Variation E default state initiated.")
		initPictureComplete = true
	end
	
	if threat == 3 then
		ScrambleKhasab29:SpawnScheduleStart()
		ScrambleIslandsF4:SpawnScheduleStart()
		ScrambleJask21A:SpawnScheduleStart()
	
		
	elseif threat == 2 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslandsF4:SpawnScheduleStart()
		ScrambleJask21A:SpawnScheduleStart()
	
		
	elseif threat == 1 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslandsF4:SpawnScheduleStop()
		ScrambleJask21A:SpawnScheduleStart()

	else	
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslandsF4:SpawnScheduleStop()
		ScrambleJask21A:SpawnScheduleStop()
	end
end

local function VariationF(threat)

	if initPictureComplete == false then
	
		VarBIslF4()
		VarAJask21()
		VarAQW29()
		VarBQE29()
		TomcatsB()
		TomcatsC()
		ScrambleIslandsF4()
		ScrambleJask21B()
		ScrambleKhasab29()
		
		env.info("PROP-AIR: Variation F default state initiated.")
		initPictureComplete = true
	end
	
	if threat == 3 then
		ScrambleKhasab29:SpawnScheduleStart()
		ScrambleIslandsF4:SpawnScheduleStart()
		ScrambleJask21B:SpawnScheduleStart()
	
		
	elseif threat == 2 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslandsF4:SpawnScheduleStart()
		ScrambleJask21B:SpawnScheduleStart()
	
		
	elseif threat == 1 then
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslandsF4:SpawnScheduleStop()
		ScrambleJask21B:SpawnScheduleStart()

	else	
		ScrambleKhasab29:SpawnScheduleStop()
		ScrambleIslandsF4:SpawnScheduleStop()
		ScrambleJask21B:SpawnScheduleStop()
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
		
	elseif redVariationValue == 4 then
	
		VariationD(airThreatLevel)
		
	elseif redVariationValue == 5 then
	
		VariationE(airThreatLevel)
	
	elseif redVariationValue == 6 then
	
		VariationF(airThreatLevel)
	
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