-- Proportional Red Air Response --

function JaskF4A()
end

local JaskDefences = math.random(1,2)

function PlayerCountInit()
    timer.scheduleFunction(PlayerCountChecker, {}, timer.getTime()+1)
end

PlayerCountInit()

function PlayerCountChecker()
    local PlayerCount = coalition.getPlayers(2)
    timer.scheduleFunction(JaskDefencesUpdater, PlayerCount, timer.getTime()+5)
    timer.scheduleFunction(IslandsDefencesUpdater, PlayerCount, timer.getTime()+5)
    etc. for each zone
    return timer.getTime() + 300
end
    
function JaskDefencesUpdater(PlayerCount)
    local JaskPhantomsOrTigers = math.random(1,2)
    if PlayerCount >= 1 and PlayerCount < 10 and JaskPhantomsOrTigers == 1
        then
            JaskF4A:SpawnScheduleStart()
            JaskF4B:SpawnScheduleStop()
            JaskF4C:SpawnScheduleStop()
    elseif PlayerCount >= 10 and PlayerCount < 20 and JaskPhantomsOrTigers == 1
        then
            JaskF4A:SpawnScheduleStart()
            JaskF4B:SpawnScheduleStart()
            JaskF4C:SpawnScheduleStop()
    elseif PlayerCount >= 20 and PlayerCount < 30 and JaskPhantomsOrTigers == 1
        then
            JaskF4A:SpawnScheduleStart()
            JaskF4B:SpawnScheduleStart()
            JaskF4C:SpawnScheduleStart()
    elseif PlayerCount >= 1 and PlayerCount < 10 and JaskPhantomsOrTigers == 2
        then
            JaskF5A:SpawnScheduleStart()
            JaskF5B:SpawnScheduleStop()
            JaskF5C:SpawnScheduleStop()
    elseif PlayerCount >= 10 and PlayerCount < 20 and JaskPhantomsOrTigers == 2
        then
            JaskF5A:SpawnScheduleStart()
            JaskF5B:SpawnScheduleStart()
            JaskF5C:SpawnScheduleStop()
    elseif PlayerCount >= 20 and PlayerCount < 30 and JaskPhantomsOrTigers == 2
        then
            JaskF5A:SpawnScheduleStart()
            JaskF5B:SpawnScheduleStart()
            JaskF5C:SpawnScheduleStart()
    end
end
                        
                        
-- This should allow for rudimentary implementation of a scaling red air response. Also try using MOOSE spawnrandomtemplate to avoid having to write extremely long and unnecessarily complex logic and if statements.






        

