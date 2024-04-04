
require "BuildingObjects/ISBuildingObject"

ISWaterDitch = ISBuildingObject:derive("ISWaterDitch")
ISWaterDitch.waterScale = 4
ISWaterDitch.waterMax = 1200

ISWaterDitch.sprites = {
    storage = {
        empty = 'rc_natural_ditch_0',
        half = 'rc_natural_ditch_1',
        full = 'rc_natural_ditch_2',
    },
    WE = {
        empty = 'rc_natural_ditch_3',
        half = 'rc_natural_ditch_4',
        full = 'rc_natural_ditch_5',
    },
    NS = {
        empty = 'rc_natural_ditch_6',
        half = 'rc_natural_ditch_7',
        full = 'rc_natural_ditch_8',
    },
}


function ISWaterDitch:create(x, y, z, north, sprite)
    local cell = getWorld():getCell()
    self.sq = cell:getGridSquare(x, y, z)
    for i=0, self.sq:getObjects():size()-1 do
        local object = self.sq:getObjects():get(i)
        if object:getProperties() and object:getProperties():Is(IsoFlagType.canBeRemoved) then
            self.sq:transmitRemoveItemFromSquare(object)
            self.sq:RemoveTileObject(object)
            break
        end
    end
    self.sq:disableErosion()
    local args = { x = self.sq:getX(), y = self.sq:getY(), z = self.sq:getZ() }
    sendClientCommand('erosion', 'disableForSquare', args)

    self.javaObject = IsoThumpable.new(cell, self.sq, sprite, north, self)
    self.javaObject:setCanPassThrough(self.canPassThrough)
	self.javaObject:setBlockAllTheSquare(self.blockAllTheSquare)
    self.javaObject:setName(self.name)
    self.javaObject:setIsThumpable(self.isThumpable)

    self.sq:AddSpecialObject(self.javaObject)
    self.sq:RecalcAllWithNeighbours(true)

    self.javaObject:setBlockAllTheSquare(true)
    self.javaObject:getSprite():setName(sprite)
    self.javaObject:getSprite():getProperties():Set(IsoFlagType.solidtrans)
    
    self.javaObject:getModData().waterMax = self.waterMax
    self.javaObject:getModData().waterAmount = 0
    self.javaObject:getModData().spriteName = sprite
    self.javaObject:getModData().objectName = self.name
    self.javaObject:transmitCompleteItemToServer()

    triggerEvent("OnObjectAdded", self.javaObject)

end


function ISWaterDitch:walkTo(x, y, z)
    local playerObj = getSpecificPlayer(self.player)
    local square = getCell():getGridSquare(x, y, z)
    return luautils.walkAdj(playerObj, square)
end


function ISWaterDitch:new(player, shovel, sprite, northSprite)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o:init()
    o:setSprite(sprite)
    o:setNorthSprite(northSprite or sprite)
    o.name = "Water Ditch"
    o.player = player
    o.waterMax = ISWaterDitch.waterMax
    o.noNeedHammer = true
    o.ignoreNorth = false
    o.equipBothHandItem = shovel
    o.maxTime = 200
    o.isThumpable = true  -- false will not block the square. and must setName to the JavaObject.
    o.canPassThrough = false
	o.blockAllTheSquare = true
    o.actionAnim = ISFarmingMenu.getShovelAnim(shovel)
    o.craftingBank = "Shoveling"
    return o
end

-- return the health of the new stairs, it's 500 + 100 per carpentry lvl
function ISWaterDitch:getHealth()
    return 500 + buildUtil.getWoodHealth(self)
end

function ISWaterDitch:render(x, y, z, square)
    -- render the first part
    local spriteName = self:getSprite()
    local sprite = IsoSprite.new()
    sprite:LoadFramesNoDirPageSimple(spriteName)
    
    local floor = square:getFloor()
    if not floor then
        return
    end
    local spriteFree = self:isValid(square) and ISWaterDitch.shovelledFloorCanDig(square)

    if spriteFree and z==0 then
        sprite:RenderGhostTile(x, y, z)
    else
        sprite:RenderGhostTileRed(x, y, z)
    end
end


function ISWaterDitch:isValid(square)
    if square:getZ() > 0 then
        return false
    end

    local floor = square:getFloor()
    if not ISBuildingObject.isValid(self, square) or not ISWaterDitch.isValidFloorTexture(floor) then
        return false
    end

    if not ISWaterDitch.shovelledFloorCanDig(square) then
        return false
    end
    
    return true
end


function ISWaterDitch.isRiverSquare(square)
    if square and square:getFloor() then
        local sprite = square:getFloor():getSprite()
        if sprite and sprite:getProperties() then
            local is_water_sprite = luautils.stringStarts(sprite:getName(), 'blends_natural_02')
            return sprite:getProperties():Is(IsoFlagType.water) and is_water_sprite and not square:isFree(false)
        else
            return false
        end
    else
        return false
    end
end


function ISWaterDitch.getDitch(square)
    for i=0, square:getObjects():size()-1 do
        local object = square:getObjects():get(i)
        if object:getName() == "Water Ditch" then
            return object
        end
    end
    return false
end


function ISWaterDitch.isValidFloorTexture(floor)
    if floor and floor:getTextureName() then
        local tex = floor:getTextureName()
        return luautils.stringStarts(tex, "floors_exterior_natural") or luautils.stringStarts(tex, "blends_natural_01")
    else
        return false
    end
end


function ISWaterDitch.shovelledFloorCanDig(square)
    if (not square) or (not square:getFloor()) then
        return false
    end
    if square:isInARoom() then
        return false
    end
    local floor = square:getFloor()
    
    if not floor then return false end

    local sprites = floor:getModData() and floor:getModData().shovelledSprites
    if sprites then
        for i=1,#sprites do
            local sprite = sprites[i]
            if luautils.stringStarts(sprite, "floors_exterior_natural") or luautils.stringStarts(sprite, "blends_natural_01") then
                return true
            end
        end
        return false
    else
        return true
    end
    --return false
end


function ISWaterDitch.canDigHere(worldObjects)
    local squares = {}
    local didSquare = {}
    for _,worldObj in ipairs(worldObjects) do
        if not didSquare[worldObj:getSquare()] then
            table.insert(squares, worldObj:getSquare())
            didSquare[worldObj:getSquare()] = true
        end
    end
    for _,square in ipairs(squares) do
        if square:getZ() > 0 then
            return false
        end
        local floor = square:getFloor()
        if ISWaterDitch.isValidFloorTexture(floor) then
            return true
        end
    end
    return false
end

