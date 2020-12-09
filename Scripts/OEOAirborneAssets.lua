-- OEO Permanent Assets Handler --

local function logisticAssets()


	local function ARCO()
	  ARCOSpawner = SPAWN:NewWithAlias("ARCO", "ARCO #IFF:5111FR")
	  :InitLimit(1, 0)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  :SetCAllsign(1,1)
	  
	 end
	 
	local function ARCSLO()
		ARCSLOSpawner = SPAWN:NewWithAlias("ARC-SLO", "ARCO #IFF:5121FR")
		:InitLimit(1, 0)
		:SpawnScheduled(10, 0)
		:InitRepeatOnLanding()
		:SetCAllsign(2,1)
	
	end
	 
	local function SHELL()
	  SHELLSpawner = SPAWN:NewWithAlias("SHELL", "SHELL #IFF:5011FR")
	  :InitLimit(1, 0)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  :SetCAllsign(1,1)
	 end
	 
	local function TEXACO()
	  TEXACOSpawner = SPAWN:NewWithAlias("TEXACO", "TEXACO #IFF:5211FR)
	  :InitLimit(1, 0)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  :SetCAllsign(1,1)
	 end

	local function MAGIC()
	  MAGICSpawner = SPAWN:NewWithAlias("MAGIC", "MAGIC #IFF:3001FR)
	  :InitLimit(1, 0)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  
	 end
	 
	local function DARKSTAR()
	  DARKSTARSpawner = SPAWN:NewWithAlias("DARKSTAR", "DARKSTAR #IFF:3011FR)
	  :InitLimit(1, 0)
	  :SpawnScheduled(10, 0)
	  :InitRepeatOnLanding()
	  
	end

	local function IranAWACS()
		IranAWACSSpawner = SPAWN:New("IranAWACS")
		:InitLimit(1, 0)
		:SpawnScheduled(1800, 0)
		:InitRepeatOnLanding()

	end
	 
	ARCO()
	ARCSLO()
	SHELL()
	TEXACO()
	MAGIC()
	DARKSTAR()
	IranAWACS()

end

logisticAssets()
