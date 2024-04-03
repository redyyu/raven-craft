--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObject"

CWaterDitchGlobalObject = CGlobalObject:derive("CWaterDitchGlobalObject")

function CWaterDitchGlobalObject:new(luaSystem, globalObject)
	local o = CGlobalObject.new(self, luaSystem, globalObject)
	return o
end

function CWaterDitchGlobalObject:getObject()
	return self:getIsoObject()
end
