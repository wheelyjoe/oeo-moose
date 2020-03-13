-- Operation Enduring Odyssey Loadouts Limitation Script --#

--TODO: CREATE INDIVIDUAL MAX LOADOUT COUNTS PER AIRFRAME

TakeoffLoadoutCheck = {}
AddLoadoutF10Check = {}

-- Define Values for all Limited Ordnance --

local RestrictedWeapons = {

						{	["weaponName"] = "AIM-120C",
							["weaponValue"] = 3,
						},
						{	["weaponName"] = "AIM-120B",
							["weaponValue"] = 3,
						},
						{	["weaponName"] = "AIM-54A-Mk47", 
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AIM-54A-Mk60",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AIM-54C-Mk47",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "SD-10",
							["weaponValue"] = 3,
						},
						{	["weaponName"] = "R-77",
							["weaponValue"] = 3,
						},
						{	["weaponName"] = "GBU-10",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "GBU-12",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "GBU-16",
							["weaponValue"] = 7,
						},
						{	["weaponName"] = "GBU-24",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "GBU-38",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "GBU-31",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "GBU-31(V)3/B",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "AGM-62",
							["weaponValue"] = 7,
						},
						{	["weaponName"] = "GB-6 HE",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "GB-6 SFW",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "LS-5-600",
							["weaponValue"] = 8,
						},
						{	["weaponName"] = "C-802AKG",
							["weaponValue"] = 16,
						},
						{	["weaponName"] = "C-802AK",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "AGM-88C",
							["weaponValue"] = 7,
						},
						{	["weaponName"] = "AGM-84D",
							["weaponValue"] = 7,
						},
						{	["weaponName"] = "LD-10",
							["weaponValue"] = 7,
						},
						{	["weaponName"] = "AGM-154A",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "AGM-154C",
							["weaponValue"] = 11,
						},
						{	["weaponName"] = "AGM-65E",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AGM-65F",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AGM-65D",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AGM-65G",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AGM-65H",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AGM-65K",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "C-701T",
							["weaponValue"] = 6,
						},
						{	["weaponName"] = "C-701IR",
							["weaponValue"] = 6,
						},
						{	["weaponName"] = "CBU-87",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "CBU-97",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "CBU-99",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "CBU-107",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "CBU-109",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "Mk-20",
							["weaponValue"] = 5,
						},
}

-- Define Maximum Allowed Values for all Airframes --

local RestrictedAirframes = {
						["Default"] = {
							["Type"] = "DefaultValues",
							["AAMax"] = 20,
							["AGMax"] = 30,
						},
						{	["Type"] = "A-10C",
							["AAMax"] = 20,
							["AGMax"] = 40,
						},
}
	

function LoadoutChecker(target)
	--env.info("BEGINNING LOADOUT CHECKER")
	local EquippedLoadout = target:getAmmo()
	local AirLoadoutValue = 0
	local GroundLoadoutValue = 0
	local WeaponValue = 0
	local AirframeMaxAA = 0
	local AirframeMaxAG = 0
	
	--env.info("Target Type is an "..target:getTypeName())	
	
	for k = 1, #RestrictedAirframes do
		if target:getTypeName() == RestrictedAirframes[k].Type
			then
				AirframeMaxAA = RestrictedAirframes[k].AAMax
				AirframeMaxAG = RestrictedAirframes[k].AGMax
			else
				AirframeMaxAA = RestrictedAirframes["Default"].AAMax
				AirframeMaxAG = RestrictedAirframes["Default"].AGMax
		end
	end

	--env.info("Target AA Max = "..AirframeMaxAA)
	--env.info("Target AG Max = "..AirframeMaxAG)
	
	for i = 1, #EquippedLoadout do
		local TotalWeaponValue = 0
		local EquippedWeaponCount = EquippedLoadout[i].count
		local EquippedWeaponName = EquippedLoadout[i].desc.displayName
		--env.info("Target has "..EquippedWeaponCount.." "..EquippedWeaponName.." on board.")
		for j = 1, #RestrictedWeapons do
			if EquippedWeaponName == RestrictedWeapons[j].weaponName
				then
					local WeaponValue = RestrictedWeapons[j].weaponValue
					--env.info("Weapon Value set to "..WeaponValue)
					TotalWeaponValue = WeaponValue * EquippedWeaponCount
					--env.info("Total Weapon Value set to "..TotalWeaponValue)
			end
		end
		--env.info("Total Weapon Value = "..TotalWeaponValue)
		if EquippedWeaponName == "AIM-120C" or EquippedWeaponName == "AIM-120B" or EquippedWeaponName == "SD-10" or EquippedWeaponName == "R-77"
			then
				--env.info("Its an AA Missile.")
				AirLoadoutValue = AirLoadoutValue + TotalWeaponValue
				--env.info("Set Air Value to "..AirLoadoutValue)
		else
				--env.info("Its a Ground Weapon.")
				GroundLoadoutValue = GroundLoadoutValue + TotalWeaponValue
				--env.info("Set Ground Value to "..GroundLoadoutValue)
				
			end
		--env.info("Air Value = "..AirLoadoutValue)
		--env.info("Ground Value = "..GroundLoadoutValue)
		end
		
	if	AirLoadoutValue > AirframeMaxAA or GroundLoadoutValue > AirframeMaxAG
		then
			if target:inAir() == true
				then
					trigger.action.outTextForGroup(target:getGroup():getID(), "Your equipped loadout is invalid! You have five minutes to land at a NATO airbase and rearm before you will be kicked to spectator. Loadout limits and weapon costs are outlined in the briefing images and document, and you can use the F10 Menu to validate your loadout.", 60, 1)
					timer.scheduleFunction(PlayerKicker, target, timer.getTime() + 300)
			else
					trigger.action.outTextForGroup(target:getGroup():getID(), "Current A/A Weaponry Cost = "..AirLoadoutValue.."/"..AirframeMaxAA..".\nCurrent A/G Weaponry Cost = "..GroundLoadoutValue.."/"..AirframeMaxAG..".\nYou are over budget! Please re-arm to a cheaper loadout before departing, or you will be kicked to spectator!", 20, 1)
		end
	elseif AirLoadoutValue <= AirframeMaxAA and GroundLoadoutValue <= AirframeMaxAG
		then
			if target:inAir() == true
				then
					return
			else
				trigger.action.outTextForGroup(target:getGroup():getID(), "Current A/A Weaponry Cost = "..AirLoadoutValue.."/"..AirframeMaxAA..".\nCurrent A/G Weaponry Cost = "..GroundLoadoutValue.."/"..AirframeMaxAG..".\nYour current loadout is valid, you may depart and fly your mission. Good luck!", 20, 1)
			end
		end
	end

-- Create F10 Entry for Players to Check Current Loadout --

function AddLoadoutF10Check:onEvent(event)
	if event.id == 15 and event.initiator and event.initiator:getPlayerName() ~= nil
		then
			local SpawnedPlayer = event.initiator
			missionCommands.addCommandForGroup(SpawnedPlayer:getGroup():getID(), "Validate Loadout", nil, LoadoutChecker, SpawnedPlayer)
	end
end

-- Perform Loadout Check on Player Takeoff --

function TakeoffLoadoutCheck:onEvent(event)
	if event.id == 3 and event.initiator and event.initiator:getPlayerName() ~= nil
		then
			--env.info("Player Departed, checking loadout")
			local LoadoutCheckTarget = event.initiator
			timer.scheduleFunction(LoadoutChecker, LoadoutCheckTarget, timer.getTime() + 3)
	end
end

function PlayerKicker(target)
	--env.info("Starting Kick Check!")
	if target:inAir() == false
		then
			--env.info("Target has landed, aborting!")
			return
	else
		local EquippedLoadout = target:getAmmo()
	local AirLoadoutValue = 0
	local GroundLoadoutValue = 0
	local WeaponValue = 0
	local AirframeMaxAA = 0
	local AirframeMaxAG = 0
	
	--env.info("Target Type is an "..target:getTypeName())	
	
	for k = 1, #RestrictedAirframes do
		if target:getTypeName() == RestrictedAirframes[k].Type
			then
				AirframeMaxAA = RestrictedAirframes[k].AAMax
				AirframeMaxAG = RestrictedAirframes[k].AGMax
			else
				AirframeMaxAA = RestrictedAirframes["Default"].AAMax
				AirframeMaxAG = RestrictedAirframes["Default"].AGMax
		end
	end

	--env.info("Target AA Max = "..AirframeMaxAA)
	--env.info("Target AG Max = "..AirframeMaxAG)
	
	for i = 1, #EquippedLoadout do
		local TotalWeaponValue = 0
		local EquippedWeaponCount = EquippedLoadout[i].count
		local EquippedWeaponName = EquippedLoadout[i].desc.displayName
		--env.info("Target has "..EquippedWeaponCount.." "..EquippedWeaponName.." on board.")
		for j = 1, #RestrictedWeapons do
			if EquippedWeaponName == RestrictedWeapons[j].weaponName
				then
					local WeaponValue = RestrictedWeapons[j].weaponValue
					--env.info("Weapon Value set to "..WeaponValue)
					TotalWeaponValue = WeaponValue * EquippedWeaponCount
					--env.info("Total Weapon Value set to "..TotalWeaponValue)
			end
		end
		--env.info("Total Weapon Value = "..TotalWeaponValue)
		if EquippedWeaponName == "AIM-120C" or EquippedWeaponName == "AIM-120B" or EquippedWeaponName == "SD-10" or EquippedWeaponName == "R-77"
			then
				--env.info("Its an AA Missile.")
				AirLoadoutValue = AirLoadoutValue + TotalWeaponValue
				--env.info("Set Air Value to "..AirLoadoutValue)
		else
				--env.info("Its a Ground Weapon.")
				GroundLoadoutValue = GroundLoadoutValue + TotalWeaponValue
				--env.info("Set Ground Value to "..GroundLoadoutValue)
				
			end
		--env.info("Air Value = "..AirLoadoutValue)
		--env.info("Ground Value = "..GroundLoadoutValue)
		end
		
	if	AirLoadoutValue > AirframeMaxAA or GroundLoadoutValue > AirframeMaxAG
			then
				--env.info("Destroying Target!")
				local NameOfGroup = target:getGroup():getName()
				--env.info("Group name = "..NameOfGroup)
				trigger.action.setUserFlag(target:getGroup():getName(), 100)
				--env.info("Set Flag to 100")
			else
				return
		end
	end
end

world.addEventHandler(TakeoffLoadoutCheck)
world.addEventHandler(AddLoadoutF10Check)