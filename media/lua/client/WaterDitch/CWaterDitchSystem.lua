--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObjectSystem"

CWaterDitchSystem = CGlobalObjectSystem:derive("CWaterDitchSystem")

function CWaterDitchSystem:new()
	local o = CGlobalObjectSystem.new(self, "waterditch")
	return o
end

function CWaterDitchSystem:isValidIsoObject(isoObject)
	return instanceof(isoObject, "IsoThumpable") and isoObject:getName() == "Water Ditch"
end

function CWaterDitchSystem:newLuaObject(globalObject)
	return CRainBarrelGlobalObject:new(self, globalObject)
end

CGlobalObjectSystem.RegisterSystemClass(CWaterDitchSystem)
