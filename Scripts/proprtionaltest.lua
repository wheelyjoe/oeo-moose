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
	if Tick > 10
		then
			TestGroupASpawner:SpawnScheduleStart()
			TestGroupBSpawner:SpawnScheduleStop()
			TestGroupCSpawner:SpawnScheduleStop()
			TestGroupDSpawner:SpawnScheduleStop()
			return 60
	elseif Tick > 8
		then
			TestGroupASpawner:SpawnScheduleStart()
			TestGroupBSpawner:SpawnScheduleStart()
			TestGroupCSpawner:SpawnScheduleStart()
			TestGroupDSpawner:SpawnScheduleStart()
			return 60
	elseif Tick > 6
		then
			TestGroupASpawner:SpawnScheduleStart()
			TestGroupBSpawner:SpawnScheduleStart()
			TestGroupCSpawner:SpawnScheduleStart()
			TestGroupDSpawner:SpawnScheduleStop()
			return 60
	elseif Tick > 4
		then
			TestGroupASpawner:SpawnScheduleStart()
			TestGroupBSpawner:SpawnScheduleStart()
			TestGroupCSpawner:SpawnScheduleStop()
			TestGroupDSpawner:SpawnScheduleStop()
			return 60
	elseif Tick > 2
		then
			--TestGroupASpawner:SpawnScheduleStart()
			TestGroupBSpawner:SpawnScheduleStart()
			--TestGroupCSpawner:SpawnScheduleStop()
			--TestGroupDSpawner:SpawnScheduleStop()
			return 60
	else
		env.info("Nothing, return 60")
		return 60
	end
end

GroupsUpdateScheduler()
