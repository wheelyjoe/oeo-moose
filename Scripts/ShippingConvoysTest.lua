-- Shipping Convoys Test -- Operation Enduring Odyssey --

-- Set Variable for Which convoy
-- spawn that convoy
-- set description string to correct info
-- take time of spawn
-- schedule despawn of convoy for one hour later

-- Define Convoys --

F10Menu = {}

local ConvoyInfo = "No convoys are currently transitting the strait."
local ConvoyActive = 0
local TotalConvoys = 0

local function Convoy1()
	Convoy1 = SPAWN:NewWithAlias("Convoy1", "TargetConvoy")
	:Spawn()
end

local Convoy1Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 25° 41' 16 \nE 57° 07' 31 \non a course of 335°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."
						

local function Convoy2()
	Convoy2 = SPAWN:NewWithAlias("Convoy2", "TargetConvoy")
	:Spawn()
end

local Convoy2Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 25° 57' 41 \nE 53° 41' 17 \non a course of 090°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."

local function Convoy3()
	Convoy3 = SPAWN:NewWithAlias("Convoy3", "TargetConvoy")
	:Spawn()
end

local Convoy3Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 26° 01' 12 \nE 55° 20' 56 \non a course of 050°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."

local function Convoy4()
	Convoy4 = SPAWN:NewWithAlias("Convoy4", "TargetConvoy")
	:Spawn()
end

local Convoy4Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 26° 42' 15 \nE 52° 28' 50 \non a course of 125°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."

local function Convoy5()
	Convoy5 = SPAWN:NewWithAlias("Convoy5", "TargetConvoy")
	:Spawn()
end

local Convoy5Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 26° 51' 14 \nE 56° 38' 15 \non a course of 160°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."

local function Convoy6()
	Convoy6 = SPAWN:NewWithAlias("Convoy6", "TargetConvoy")
	:Spawn()
end

local Convoy6Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 26° 41' 56 \nE 56° 17' 21 \non a course of 230°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."

local function Convoy7()
	Convoy7 = SPAWN:NewWithAlias("Convoy7", "TargetConvoy")
	:Spawn()
end

local Convoy7Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 26° 24' 06 \nE 55° 04' 05 \non a course of 275°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."

local function Convoy8()
	Convoy8 = SPAWN:NewWithAlias("Convoy8", "TargetConvoy")
	:Spawn()
end

local Convoy8Info = "A convoy consisting of Iranian Warships escorting various cargo vessels has been spotted transitting the Strait of Hormuz. \nA strike has been authorised to destroy it as quickly as possible. The convoy was last seen roughly an hour ago at the following coordinates: \nN 26° 03' 07 \nE 54° 49' 54 \non a course of 275°. \n \nFind and destroy the convoy, both the Cargo ships and the escorting Warships are valid targets. \nWe estimate the strike window to be 1 hour. \n \nRecommended Pilots: 2+ \nRecommended Ordnance: Anti Shipping Missiles, such as AGM-84E Harpoons or RB-04E."


--Despawn Convoy--

local function ConvoyDespawn()
	env.info("Entered Despawn")
	local TotalString = tostring(TotalConvoys)
	local ConvoyName = 'TargetConvoy#00'..TotalString
	local DestroyGrp = Group.getByName(ConvoyName)
	trigger.action.deactivateGroup(DestroyGrp)
	ConvoyActive = 0
end

-- Spawn Convoy Function --

local function SpawnConvoy()

	local var = math.random(1, 8)
	
	if var == 1 then
	
		Convoy1()
		ConvoyInfo = Convoy1Info
		env.info("Convoy Spawned")
		
	elseif var == 2 then
	
		Convoy2()
		ConvoyInfo = Convoy2Info
		
	elseif var == 3 then
	
		Convoy3()
		ConvoyInfo = Convoy3Info
		
	elseif var == 4 then
	
		Convoy4()
		ConvoyInfo = Convoy4Info
		
	elseif var == 5 then
	
		Convoy5()
		ConvoyInfo = Convoy5Info
		
	elseif var == 6 then
	
		Convoy6()
		ConvoyInfo = Convoy6Info
		
	elseif var == 7 then
	
		Convoy7()
		ConvoyInfo = Convoy7Info
		
	elseif var == 8 then
	
		Convoy8()
		ConvoyInfo = Convoy8Info
		
	end
	
	TotalConvoys = TotalConvoys + 1
	timer.scheduleFunction(ConvoyDespawn, nil, timer.getTime() + 3600)
	env.info("scheduled despawn")
	
end

local function requestHandler(group)

	if ConvoyActive ~= 0
		then
			trigger.action.outTextForGroup(group, "An active convoy hunt is already underway. Information to follow.", 15, 1)
			trigger.action.outTextForGroup(group, ConvoyInfo, 60, 1)
			env.info("Convoy already out")
		return
	else
	
	SpawnConvoy()
	trigger.action.outTextForGroup(group, ConvoyInfo, 60, 1)
	ConvoyActive = 1
	env.info("request handled")
	
	end
end

local PlayerGroupIDs = {}

function F10Menu:onEvent(event)
    if event.id == world.event.S_EVENT_BIRTH and event.initiator and event.initiator:getPlayerName() ~= nil 
		then
			local PlayerID = event.initiator:getGroup():getID()
			if PlayerGroupIDs[PlayerID] == nil then
				PlayerGroupIDs[PlayerID] = true
				missionCommands.addCommandForGroup(PlayerID, "Request Anti Ship Strike", nil, requestHandler, PlayerID)
        end
    end
end

world.addEventHandler(F10Menu)