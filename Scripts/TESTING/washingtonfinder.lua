checker = {}

function checker:onEvent(event)
	if event.id == world.event.S_EVENT_TAKEOFF
		then
			env.info("Found a takeoff.")
			env.info("Name of carrier is "..event.place:getTypeName())
		end
end

world.addEventHandler(checker)