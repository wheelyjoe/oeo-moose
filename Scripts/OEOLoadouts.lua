-- Operation Enduring Odyssey Loadouts Limitation Script --#

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
						{	["weaponName"] = "AIM_54A_Mk47", 
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AIM_54A_Mk60",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "AIM_54C_Mk47",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "SD-10",
							["weaponValue"] = 3,
						},
						{	["weaponName"] = "R-77",
							["weaponValue"] = 3,
						},
						{	["weaponName"] = "GBU-10",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "GBU-12",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "GBU-16",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "GBU-24",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "GBU-38",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "GBU-31",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "GBU-31(V)3/B",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "AGM-62",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "GB-6-HE",
							["weaponValue"] = 20,
						},
						{	["weaponName"] = "GB-6-SFW",
							["weaponValue"] = 30,
						},
						{	["weaponName"] = "LS-6-500",
							["weaponValue"] = 30,
						},
						{	["weaponName"] = "CM-802AKG",
							["weaponValue"] = 40,
						},
						{	["weaponName"] = "C-802AK",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "AGM-88C",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "AGM-84D",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "LD-10",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "AGM-154A",
							["weaponValue"] = 30,
						},
						{	["weaponName"] = "AGM-154C",
							["weaponValue"] = 30,
						},
						{	["weaponName"] = "AGM-65E",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "AGM-65F",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "AGM-65D",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "AGM-65G",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "AGM-65H",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "AGM-65K",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "C-701T",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "C-701IR",
							["weaponValue"] = 10,
						},
						{	["weaponName"] = "CBU-87",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "CBU-97",
							["weaponValue"] = 15,
						},
						{	["weaponName"] = "CBU-99",
							["weaponValue"] = 5,
						},
						{	["weaponName"] = "CBU-105",
							["weaponValue"] = 15,
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
							["AGMax"] = 60,
						},
						{	["Type"] = "A-10C",
							["AAMax"] = 20,
							["AGMax"] = 80,
						},
}
	

function LoadoutChecker(targetGroup)
	--env.info("BEGINNING LOADOUT CHECKER")
	local target = targetGroup:getUnit(1)
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
			if EquippedWeaponName == "RN-24" or EquippedWeaponName == "RN-28"
				then
					timer.scheduleFunction(NukeChecker, target, timer.getTime() + 1)
					return
			else if EquippedWeaponName == RestrictedWeapons[j].weaponName
				then
					local WeaponValue = RestrictedWeapons[j].weaponValue
					--env.info("Weapon Value set to "..WeaponValue)
					TotalWeaponValue = WeaponValue * EquippedWeaponCount
					--env.info("Total Weapon Value set to "..TotalWeaponValue)
				end
			end
		end
		--env.info("Total Weapon Value = "..TotalWeaponValue)
		if EquippedWeaponName == "AIM-120B" or EquippedWeaponName == "AIM-120C" or EquippedWeaponName == "AIM_54A_Mk47" or  EquippedWeaponName == "AIM_54A_Mk60" or EquippedWeaponName == "AIM_54C_Mk47" or EquippedWeaponName == "SD-10" or EquippedWeaponName == "R-77"
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
					timer.scheduleFunction(KickWarning, target, timer.getTime() + 240)
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

LoadoutsMenuPlayerIDs = {}

function AddLoadoutF10Check:onEvent(event)
	if event.id == world.event.S_EVENT_BIRTH and event.initiator and event.initiator:getPlayerName() ~= nil
		then
			local SpawnedPlayer = event.initiator
			local PlayerID = SpawnedPlayer:getGroup():getID()
				if 	LoadoutsMenuPlayerIDs[PlayerID] == nil 
					then	
						LoadoutsMenuPlayerIDs[PlayerID] = true
						missionCommands.addCommandForGroup(PlayerID, "Validate Loadout", nil, LoadoutChecker, SpawnedPlayer:getGroup())
				else
					return
			end
	end
end

-- Perform Loadout Check on Player Takeoff --

function TakeoffLoadoutCheck:onEvent(event)
	if event.id == world.event.S_EVENT_TAKEOFF and event.initiator and event.initiator:getPlayerName() ~= nil
		then
			--env.info("Player Departed, checking loadout")
			local LoadoutCheckTarget = event.initiator:getGroup()
			timer.scheduleFunction(LoadoutChecker, LoadoutCheckTarget, timer.getTime() + 3)
	end
end

function KickWarning(target)
	if target:inAir() == true
		then
			trigger.action.outTextForGroup(target:getGroup():getID(), "WARNING! You are still airborne with an invalid loadout! You will be removed to spectator in ONE MINUTE unless you land and re-arm!", 30, 1)
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
				trigger.action.outTextForGroup(target:getGroup():getID(), "You have been removed to spectator for flying with an invalid loadout. Please read the loadout limits in the briefing & briefing images, and use a valid loadout. You can use the F10 Menu to validate your loadout before departing.", 60, 1)
				trigger.action.setUserFlag(target:getGroup():getName(), 100)
				--env.info("Set Flag to 100")
			else
				return
		end
	end
end

function NukeChecker(target)
	if target:inAir() == false
		then
			trigger.action.outTextForGroup(target:getGroup():getID(), "You have loaded a Nuclear Weapon. Nuclear Weapons are NOT authorised in the scope of this mission. If you depart with this weapon on board, you will be IMMEDIATELY destroyed. Remove the weapon immediately.", 60, 1)
	else
			trigger.action.setUserFlag(target:getGroup():getName(), 100)
			--env.info("Kicked Player for Nukes")
	end
end
	
world.addEventHandler(TakeoffLoadoutCheck)
world.addEventHandler(AddLoadoutF10Check)