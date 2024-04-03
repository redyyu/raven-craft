
require "BuildingObjects/ISBuildingObject"

ISWaterDitch = ISBuildingObject:derive("ISWaterDitch")
ISWaterDitch.waterMax = 800

ISWaterDitch.spriteGroupMap = {
	[''] = {
		empty = 'rc_natural_ditch_0',
        water = 'rc_natural_ditch_1',
	},
    ['E'] = {
        empty = 'rc_natural_ditch_2',
        water = 'rc_natural_ditch_3',
    },
    ['WE'] = {
        empty = 'rc_natural_ditch_4',
        water = 'rc_natural_ditch_5',
    },
    ['W'] = {
        empty = 'rc_natural_ditch_6',
        water = 'rc_natural_ditch_7',
    }
	['S'] = {
        empty = 'rc_natural_ditch_8',
        water = 'rc_natural_ditch_9',
    },
    ['NS'] = {
        empty = 'rc_natural_ditch_10',
        water = 'rc_natural_ditch_11',
    },
    ['N'] = {
        empty = 'rc_natural_ditch_12',
        water = 'rc_natural_ditch_13',
    },
    ['WN'] = {
        empty = 'rc_natural_ditch_14',
        water = 'rc_natural_ditch_15',
    },
    ['ES'] = {
        empty = 'rc_natural_ditch_16',
        water = 'rc_natural_ditch_17',
    },
    ['WS'] = {
        empty = 'rc_natural_ditch_18',
        water = 'rc_natural_ditch_19',
    },
    ['EN'] = {
        empty = 'rc_natural_ditch_20',
        water = 'rc_natural_ditch_21',
    },
    ['ENS'] = {
        empty = 'rc_natural_ditch_22',
        water = 'rc_natural_ditch_23',
    },
    ['WES'] = {
        empty = 'rc_natural_ditch_24',
        water = 'rc_natural_ditch_25',
    },
    ['WEN'] = {
        empty = 'rc_natural_ditch_26',
        water = 'rc_natural_ditch_27',
    },
    ['WNS'] = {
        empty = 'rc_natural_ditch_28',
        water = 'rc_natural_ditch_29',
    },
    ['WENS'] = {
        empty = 'rc_natural_ditch_30',
        water = 'rc_natural_ditch_31',
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
    
    local sprite = ISWaterDitch.reckonSPrite(self.sq)
    self.javaObject = IsoThumpable.new(cell, self.sq, sprite, north, self)
    buildUtil.setInfo(self.javaObject, self)
    
    self.sq:RecalcAllWithNeighbours(true)
    self.sq:AddSpecialObject(self.javaObject)

    self.javaObject:getModData()["waterMax"] = self.waterMax
    self.javaObject:getModData()["waterAmount"] = 0
    self.javaObject:setSpecialTooltip(true)
    self.javaObject:transmitCompleteItemToServer()

    triggerEvent("OnObjectAdded", self.javaObject)

    self:updateAdjacentSprite()
end


function ISWaterDitch:walkTo(x, y, z)
    local playerObj = getSpecificPlayer(self.player)
    local square = getCell():getGridSquare(x, y, z)
    return luautils.walkAdj(playerObj, square)
end


function ISWaterDitch:new(player, sprite, shovel)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o:init()
    o:setSprite(sprite)
    o:setNorthSprite(sprite)
    o.name = "Water Ditch"
    o.player = player
    o.waterMax = ISWaterDitch.waterMax
    o.noNeedHammer = true
    o.ignoreNorth = true
    o.equipBothHandItem = shovel
    o.maxTime = 250
    o.isThumpable = false
    o.canBarricade = false
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
    local spriteFree = ISBuildingObject.isValid(self, square) and ISWaterDitch.isValidFloorTexture(floor)

    spriteFree = spriteFree and ISWaterDitch.shovelledFloorCanDig(square)

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

function ISWaterDitch:updateAdjacentSprite()
    local squares = {
        self.sq:getAdjacentSquare(IsoDirections.N),
        self.sq:getAdjacentSquare(IsoDirections.S),
        self.sq:getAdjacentSquare(IsoDirections.W),
        self.sq:getAdjacentSquare(IsoDirections.E),
    }
    
    for _, square in ipairs(squares) do
        local ditch = ISWaterDitch.getDitch(square)
        local spriteName = ISWaterDitch.reckonSprite(square, ditch)
        ditch:setSprite(spriteName)
		ditch:transmitUpdatedSpriteToClients()
    end
end


function ISWaterDitch.reckonSprite(square, ditch)
    local north_square = square:getAdjacentSquare(IsoDirections.N)
    local south_square = square:getAdjacentSquare(IsoDirections.S)
    local west_square = square:getAdjacentSquare(IsoDirections.W)
    local east_square = square:getAdjacentSquare(IsoDirections.E)
    
    local group = ''

    if ISWaterDitch.isWaterSquare(west_square) or ISWaterDitch.getDitch(west_square) then
        group = 'W'
    end

    if ISWaterDitch.isWaterSquare(east_square) or ISWaterDitch.getDitch(east_square) then
        group = group + 'E'
    end

    if ISWaterDitch.isWaterSquare(north_square) or ISWaterDitch.getDitch(north_square) then
        group = group + 'N'
    end

    if ISWaterDitch.isWaterSquare(south_square) or ISWaterDitch.getDitch(south_square) then
        group = group + 'S'
    end

    local sprite_group = ISWaterDitch.spriteGroupMap[group]

    if ditch and ditch:getModData()["waterAmount"] > 0 and ditch:getModData()["waterMax"] > 0 then
        if ditch:getModData()["waterAmount"] >= ditch:getModData()["waterMax"] * 0.25 then
            return sprite_group.water
        else
            return sprite_group.empty
        end
    else
        return sprite_group.empty
    end
end


function ISWaterDitch.isWaterSquare(square)
    if square and square:getFloor() then
        local sprite = square:getFloor():getSprite()
        if sprite and sprite:getProperties() then
            return sprite:getProperties():Is(IsoFlagType.water)
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

