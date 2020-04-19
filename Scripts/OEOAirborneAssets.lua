-- OEO Permanent Assets Handler --

local function logisticAssets()


	local function ARCO()
	  ARCOSpawner = SPAWN:New("ARCO")
	  :InitLimit(1, 10)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  
	 end
	 
	local function SHELL()
	  SHELLSpawner = SPAWN:New("SHELL")
	  :InitLimit(1, 10)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  
	 end

	local function MAGIC()
	  MAGICSpawner = SPAWN:New("MAGIC")
	  :InitLimit(1, 10)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  
	 end
	 
	local function DARKSTAR()
	  DARKSTARSpawner = SPAWN:New("DARKSTAR")
	  :InitLimit(1, 10)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  
	end

	local function IranAWACS()
		IranAWACSSpawner = SPAWN:New("IranAWACS")
		:InitLimit(1, 10)
		:SpawnScheduled(1800, 0)
		:InitRepeatOnLanding()

	end
	 
	ARCO()
	SHELL()
	MAGIC()
	DARKSTAR()
	IranAWACS()

end

logisticAssets()