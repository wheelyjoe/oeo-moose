local function getDetections()
  for i, gp in pairs(coalition.getGroups(1)) do
    for j, unit in pairs(gp:getUnits()) do       
      if unit:hasAttribute("SAM TR") or unit:hasAttribute("SAM SR") or unit:hasAttribute("EWR") then
        local detectedUnits = unit:getController():getDetectedTargets(Controller.Detection.RADAR)
        if #detectedUnits > 0 then
          env.info("Type of radar unit is: ".. unit:getTypeName()..", name of radar unit is: ".. unit:getName())        
          for k, detected in pairs(detectedUnits) do          
            if detected.object then
              env.info("Detected: ".. detected.object:getName())   
            end       
          end
        end
      end
    end
  end
 return timer.getTime() + 10  
end

timer.scheduleFunction(getDetections, {}, timer.getTime() + 10)
