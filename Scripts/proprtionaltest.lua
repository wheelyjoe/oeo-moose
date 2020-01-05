--Proportional Response Testing --
Tick = 0

function TestGroupA()
	TestGroupASpawner = SPAWN:New("TestGroup A")
	:InitLimit(1, 0)
	:SpawnScheduled(30, 0)
	:InitRepeatOnLanding()
end

function TestGroupB()
	TestGroupBSpawner = SPAWN:New("TestGroup B")
	:InitLimit(1, 0)
	:SpawnScheduled(30, 0)
	:InitRepeatOnLanding()
end

function TestGroupC()
	TestGroupCSpawner = SPAWN:New("TestGroup C")
	:InitLimit(1, 0)
	:SpawnScheduled(30, 0)
	:InitRepeatOnLanding()
end

function TestGroupD()
	TestGroupDSpawner = SPAWN:New("TestGroup D")
	:InitLimit(1, 0)
	:SpawnScheduled(30, 0)
	:InitRepeatOnLanding()
end

function InitialSpawnSetup()
	TestGroupA()
	TestGroupB()
	TestGroupC()
	TestGroupD()
	TestGroupASpawner:SpawnScheduleStart()
	TestGroupBSpawner:SpawnScheduleStop()
	TestGroupCSpawner:SpawnScheduleStop()
	TestGroupDSpawner:SpawnScheduleStop()
end

InitialSpawnSetup()

function GroupsUpdateScheduler()
	timer.scheduleFunction(GroupsUpdater, {}, timer.getTime() + 10)
end

function GroupsUpdater()
	env.info("Updating Groups")
	Tick = Tick + 1
	env.info("Tick = "..Tick)
	--if Tick > 3
	--	then
	--		env.info("Returning 60")
	--elseif Tick == 3
	--	then
	--		env.info("Tick = 3, running schedule start")
	--		TestGroupBSpawner:SpawnScheduleStart()
	--		env.info("Spawned Test B - returning 60")
	--		return 60
	--else
		env.info("Returning 60")
		return 60
	end
--end

GroupsUpdateScheduler()
