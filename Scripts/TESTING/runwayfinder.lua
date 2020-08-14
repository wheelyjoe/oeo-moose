-- Runway Finder --

JSON = (loadfile "JSON.lua")()

table = {}



local coords_json_text = JSON:encode(table)

for i, gp in pairs(coalition.getGroups(1)) do

	runway = gp:getGroupName()
	runway = {}
	
	a = gp:getUnit(1)
	b = gp:getUnit(2)
	c = gp:getUnit(3)
	
	runway.a.x = a:getPoint().x
	runway.a.z = a:getPoint().z
	
	runway.b.x = b:getPoint().x
	runway.b.z = b:getPoint().z
	
	runway.c.x = c:getPoint().x
	runway.c.z = c:getPoint().z
	
	table.i = runway	
	
end