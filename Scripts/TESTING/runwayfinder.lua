for i, gp in pairs(coalition.getGroups(1)) do

  gp:getName()
  
  local a = gp:getUnit(1)
  local b = gp:getUnit(2)
  local c = gp:getUnit(3)
  local d = gp:getUnit(4)
    
  env.info("[\"".. gp:getName().."\"] = {"..a:getPoint().x..", "..a:getPoint().z..", "..b:getPoint().x..", "..b:getPoint().z..", "..c:getPoint().x..", "..c:getPoint().z..", "..d:getPoint().x..", "..d:getPoint().z.."},")
  
end