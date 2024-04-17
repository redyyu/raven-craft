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

    if isoObject:getOverlaySprite() and isoObject:getOverlaySprite():getName() then
        self.overlaySpriteName = isoObject:getOverlaySprite():getName()
    else
        self.overlaySpriteName = isoObject:getModData().overlaySpriteName
    end

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


function SWaterDitchGlobalObject:isFlowable(relLuaObject)
    if not relLuaObject then return false end
    
    local isoObject = self:getIsoObject()
    if isoObject then
        if relLuaObject:isPool() then
            -- pool can not take water from pool
            return not self:isPool()
        else
            -- waterway can take water from pool or same direction waterway.
            return self:isPool() or self:getDitchType() == relLuaObject:getDitchType()
        end
    else
        return false
    end
end


function SWaterDitchGlobalObject:isWaterToFlow()
    return self.waterAmount > self.waterMax * 0.33
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

    local overlaySpriteName = nil
    local spriteName = ISWaterDitch.baseSprite

    if not self.waterMax or not self.waterAmount then
        ISWaterDitch.recognizeDitch(isoObject)
        self.waterMax = isoObject:getWaterMax() or isoObject:getModData().waterMax
        self.waterAmount = isoObject:getWaterAmount()
    end
    
    -- when use custom sprite (texture only) without `Tile`,
    -- the sprite cloud be disappear when character move far then come back.
    -- I guess this is relate the `rendering` of game engine. 
    -- use overlaySprite looks fine on client side, not test on server.

    -- waterMax is different between different ditchType.
    if self.waterAmount < self.waterMax * 0.25 then
        overlaySpriteName = isoObject:getModData().sprites.empty
    elseif self.waterAmount < self.waterMax * 0.75 then
        overlaySpriteName = isoObject:getModData().sprites.half
    else
        overlaySpriteName = isoObject:getModData().sprites.full
    end
    
    if spriteName and (not isoObject:getSprite() or spriteName ~= isoObject:getSpriteName()) then
        self:noise('sprite changed to '..spriteName..' at '..self.x..','..self.y..','..self.z)
        -- incase sprite is not same with `ISWaterDitch.baseSprite`
        self:setSpriteName(spriteName)
    end

    local overlay_sprite = isoObject:getOverlaySprite()
    if overlaySpriteName and (not overlay_sprite or overlaySpriteName ~= overlay_sprite:getName()) then
        self:noise('overlay sprite changed to '..overlaySpriteName..' at '..self.x..','..self.y..','..self.z)
        self.overlaySpriteName = overlaySpriteName
        isoObject:setOverlaySprite(overlaySpriteName)
    end

    -- spriteName and overlaySpriteName is stored in modData
    self:toModData(isoObject:getModData())
    -- also update GameTime modData
end


function SWaterDitchGlobalObject:setSpriteName(spriteName)
    if spriteName == self.spriteName then return end

    self.spriteName = spriteName
    local isoObject = self:getIsoObject()
    if isoObject then
        isoObject:setSprite(self.spriteName)
        isoObject:getSprite():setName(self.spriteName)
        if isServer() then
            isoObject:sendObjectChange('sprite')
        end
        isoObject:transmitUpdatedSpriteToClients()
    end
end


function SWaterDitchGlobalObject:toModData(modData)
    modData.exterior = self.exterior
    modData.spriteName = self.spriteName
    modData.overlaySpriteName = self.overlaySpriteName
    modData.objectName = self.objectName
end
