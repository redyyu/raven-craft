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
    self.waterMax = ISWaterDitch.waterMax
end


function SWaterDitchGlobalObject:stateFromIsoObject(isoObject)
    ISWaterDitch.recognizeDitch(isoObject)
    self.exterior = isoObject:getSquare():isOutside()
    self.taintedWater = isoObject:isTaintedWater()
    self.waterAmount = isoObject:getWaterAmount()
    self.waterMax = isoObject:getWaterMax()
    self.objectName = isoObject:getName()
    self.spriteName = isoObject:getSpriteName()

    -- Sanity check
    if not self.waterMax then
        self.waterMax = isoObject:getModData().waterMax
    end

    self:changeSprite()

    if isServer() then
        isoObject:sendObjectChange('name')
        isoObject:sendObjectChange('sprite')
        isoObject:transmitModData()
    end
end


function SWaterDitchGlobalObject:stateToIsoObject(isoObject)
    ISWaterDitch.recognizeDitch(isoObject)
    -- Sanity check
    if not self.waterAmount then
        self.waterAmount = 0
    end

    if not self.waterMax then
        self.waterMax = isoObject:getWaterMax() or isoObject:getModData().waterMax
    end

    self.exterior = isoObject:getSquare():isOutside()

    if not self.taintedWater then
        self.taintedWater = self.waterAmount > 0 and self.exterior
    end

    isoObject:setTaintedWater(self.taintedWater)
    isoObject:setWaterAmount(self.waterAmount) -- OnWaterAmountChanged happens here
    isoObject:getModData().waterMax = self.waterMax
    isoObject:setName(self.objectName)

    self:changeSprite()
    
    if isServer() then
        isoObject:sendObjectChange('name')
        isoObject:sendObjectChange('sprite')
        isoObject:transmitModData()
    end
end


function SWaterDitchGlobalObject:isPool()
    local isoObject = self:getIsoObject()
    if isoObject then
        return isoObject:getModData().ditchType == 'pool'
    else
        return false
    end
end


function SWaterDitchGlobalObject:isWaterFlowing(object)
    if not object then return false end
    
    local isoObject = self:getIsoObject()
    if isoObject then
        if object:getModData().ditchType == 'pool' then
            -- pool can not take water from pool
            return not self:isPool()
        else
            -- waterway can take water from pool or same direction waterway.
            return self:isPool() or self:getDitchType() == object:getModData().ditchType
        end
    else
        return false
    end
end


function SWaterDitchGlobalObject:getDitchType()
    local isoObject = self:getIsoObject()
    if isoObject then
        return isoObject:getModData().ditchType
    else
        return nil
    end
end


function SWaterDitchGlobalObject:changeSprite()
    local isoObject = self:getIsoObject()
    if not isoObject then return end

    local spriteName = nil

    if not self.waterMax or not self.waterAmount then
        ISWaterDitch.recognizeDitch(isoObject)
        self.waterMax = isoObject:getWaterMax() or isoObject:getModData().waterMax
        self.waterAmount = isoObject:getWaterAmount()
    end

    -- waterMax is different between different ditchType.
    if self.waterAmount < self.waterMax * 0.25 then
        spriteName = isoObject:getModData().sprites.empty
    elseif self.waterAmount < self.waterMax * 0.75 then
        spriteName = isoObject:getModData().sprites.half
    else
        spriteName = isoObject:getModData().sprites.full
    end

    if spriteName and (not isoObject:getSprite() or spriteName ~= isoObject:getSprite():getName()) then
        self:noise('sprite changed to '..spriteName..' at '..self.x..','..self.y..','..self.z)
        self:setSpriteName(spriteName)
        -- spriteName is stored in modData
        self:toModData(isoObject:getModData())
        -- also update GameTime modData
    end
end


function SWaterDitchGlobalObject:setSpriteName(spriteName)
    if spriteName == self.spriteName then return end
    self.spriteName = spriteName
    local isoObject = self:getIsoObject()
    if isoObject then
        isoObject:setSprite(self.spriteName)
        isoObject:getSprite():setName(self.spriteName)
        isoObject:getSprite():getProperties():Set(IsoFlagType.solidtrans)

        if isServer() then
            isoObject:sendObjectChange('sprite')
        end
        isoObject:transmitUpdatedSpriteToClients()
    end
end


function SWaterDitchGlobalObject:updateFloor()
    local isoObject = self:getIsoObject()
    -- make sure square is not free.
    if isoObject then
        local square = isoObject:getSquare()
        if square and square:getProperties() then
            square:getProperties():Set(IsoFlagType.solidtrans)
        end
        -- DO NOT change floor there, weird happen, etc, around is block not no reason.
        -- if square and square:getFloor() and square:getFloor():getProperties() then
        --     square:getFloor():getProperties():Set(IsoFlagType.solidtrans)
        --     square:RecalcAllWithNeighbours(true)
        -- end
    end
end


function SWaterDitchGlobalObject:toModData(modData)
    modData.exterior = self.exterior
    modData.spriteName = self.spriteName
    modData.objectName = self.objectName
end
