local function ConvoyDespawn()
	env.info("entered despawn")
	
	local TotalConvoys = 1
	
	TotalString = tostring(TotalConvoys)
	
	env.info(TotalString)
	
	local convoyname = "TargetConvoy#00"..TotalString
	
	local DestroyGrp = Group.getByName(convoyname)
	env.info("Found group by name")
	env.info("Group name = "..DestroyGrp:getName())
	trigger.action.deactivateGroup(DestroyGrp)
	env.info("despawned")
	ConvoyActive = 0
	env.info("set value")

end

ConvoyDespawn()