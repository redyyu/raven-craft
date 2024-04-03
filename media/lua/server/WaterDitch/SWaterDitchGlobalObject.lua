--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

require "Map/SGlobalObject"
require "WaterDitch/BuildingObjects/ISWaterDitch"


SWaterDitchGlobalObject = SGlobalObject:derive("SWaterDitchGlobalObject")


function SWaterDitchGlobalObject:new(luaSystem, globalObject)
	local o = SGlobalObject.new(self, luaSystem, globalObject)
	return o
end


function SWaterDitchGlobalObject:initNew()
	self.exterior = false
	self.taintedWater = false
	self.waterAmount = 0
	self.waterMax = RainCollectorBarrel.largeWaterMax
end


function SWaterDitchGlobalObject:stateFromIsoObject(isoObject)
	self.exterior = isoObject:getSquare():isOutside()
	self.taintedWater = isoObject:isTaintedWater()
	self.waterAmount = isoObject:getWaterAmount()
	self.waterMax = isoObject:getModData().waterMax

	-- Sanity check
	if not self.waterMax then
		self.waterMax = ISWaterDitch.waterMax
	end

	isoObject:getModData().waterMax = self.waterMax
	self:changeSprite()
	isoObject:transmitModData()
end


function SWaterDitchGlobalObject:stateToIsoObject(isoObject)
	-- Sanity check
	if not self.waterAmount then
		self.waterAmount = 0
	end
	if not self.waterMax then
		self.waterMax = ISWaterDitch.waterMax
	end

	self.exterior = isoObject:getSquare():isOutside()

	if not self.taintedWater then
		self.taintedWater = self.waterAmount > 0 and self.exterior
	end
	isoObject:setTaintedWater(self.taintedWater)

	isoObject:setWaterAmount(self.waterAmount) -- OnWaterAmountChanged happens here
	isoObject:getModData().waterMax = self.waterMax
	self:changeSprite()
	isoObject:transmitModData()
end


function SWaterDitchGlobalObject:changeSprite()
	local isoObject = self:getIsoObject()
	if not isoObject then return end
	local spriteName = nil
	local square = isoObject:getSquare()
	if not isoObject:getModData()["waterSprite"] or not isoObject:getModData()["emptySprite"] then
		local sprite_group = ISWaterDitch.reckonSpriteGroup(square)
		isoObject:getModData()["waterSprite"] = sprite_group.water
		isoObject:getModData()["emptySprite"] = sprite_group.empty
	end
	
	if self.waterAmount >= self.waterMax * 0.25 then
		spriteName = isoObject:getModData()["waterSprite"]
	else
		spriteName = isoObject:getModData()["emptySprite"]
	end
	
	if spriteName and (not isoObject:getSprite() or spriteName ~= isoObject:getSprite():getName()) then
		self:noise('sprite changed to '..spriteName..' at '..self.x..','..self.y..','..self.z)
		isoObject:setSprite(spriteName)
		isoObject:transmitUpdatedSpriteToClients()
	end
end

