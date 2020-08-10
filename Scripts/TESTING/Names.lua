function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

local function getDetections()
  for i, gp in pairs(coalition.getGroups(2)) do
    for j, unit in pairs(gp:getUnits()) do       
      if unit:hasAttribute("SAM SR") then
        env.info("Name of unit is: ".. unit:getTypeName())
        env.info("Detected Units: ".. table.tostring(unit:getController():getDetected(Controller.Detection.RADAR))) 
      end
    end
  end
  
  
  for i, gp in pairs(coalition.getGroups(1)) do
    for j, unit in pairs(gp:getUnits()) do       
      if unit:hasAttribute("SAM SR") then
        env.info("Name of unit is: ".. unit:getTypeName())
        env.info("Detected Units: ".. table.tostring(unit:getController():getDetected(Controller.Detection.RADAR))) 
      end
    end
  end
 return timer.getTime() + 10  
end

  timer.scheduleFunction(listDetections, {}, timer.getTime() + 10)
