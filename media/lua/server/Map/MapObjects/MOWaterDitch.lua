
if isClient() then return end

require "WaterDitch/BuildingObjects/ISWaterDitch"


local PRIORITY = 5

local function noise(message) SWaterDitchSystem.instance:noise(message) end

local function LoadDitchObject(isoObject)
	if SWaterDitchSystem:isValidIsoObject(isoObject) then
		SWaterDitchSystem.instance:loadIsoObject(isoObject)
	end
end


MapObjects.OnLoadWithSprite(ISWaterDitch.baseSprite, LoadDitchObject, PRIORITY)

