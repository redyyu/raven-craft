
require "BuildingObjects/ISBuildingObject"

ISWaterDitch = ISBuildingObject:derive("ISWaterDitch")
ISWaterDitch.waterScale = 4
ISWaterDitch.waterFlowScale = ISWaterDitch.waterScale * 5
ISWaterDitch.waterMax = 200
ISWaterDitch.poolWaterMax = 400
ISWaterDitch.skillRequired = 6

ISWaterDitch.variety = {
    pool = {
        waterMax = ISWaterDitch.poolWaterMax,
        sprites = {
            empty = 'rc_natural_ditch_0',
            half = 'rc_natural_ditch_1',
            full = 'rc_natural_ditch_2',
        }
    },
    WE = {
        waterMax = ISWaterDitch.waterMax,
        sprites = {
            empty = 'rc_natural_ditch_3',
            half = 'rc_natural_ditch_4',
            full = 'rc_natural_ditch_5',
        }
    },
    NS = {
        waterMax = ISWaterDitch.waterMax,
        sprites = {
            empty = 'rc_natural_ditch_6',
            half = 'rc_natural_ditch_7',
            full = 'rc_natural_ditch_8',
        }
    },
}
ISWaterDitch.defaultVariety = 'pool'
ISWaterDitch.dirtFillName = "Dirt Fill"
ISWaterDitch.dirtFillSprite = 'rc_natural_ditch_9'
ISWaterDitch.floorSprite = 'blends_natural_01_64'
ISWaterDitch.baseSprite = 'vegetation_farming_01_0'  -- the one has BlocksPlacement

ISWaterDitch.varietySpriteMap = {}

for variety_key, variety_val in pairs(ISWaterDitch.variety) do
    for _, v in pairs(variety_val.sprites) do
        ISWaterDitch.varietySpriteMap[v] = variety_key
    end
end


function ISWaterDitch:create(x, y, z, north, sprite)
    local cell = getWorld():getCell()
    self.sq = cell:getGridSquare(x, y, z)
    if not self.sq:getProperties() then
        return false
    end

    self.sq:disableErosion()
    local args = { x = self.sq:getX(), y = self.sq:getY(), z = self.sq:getZ() }
    sendClientCommand('erosion', 'disableForSquare', args)
    
    -- update floor
    local floor = self.sq:getFloor()
    if floor then
        floor:clearAttachedAnimSprite()
    end
    floor = self.sq:addFloor(ISWaterDitch.floorSprite)
    floor:setName(ISWaterDitch.floorSprite)
    -- don't worry dig furrow on ditch, it's already fixed by `patch_farmingPlot.lua`

    local removes = {}
    for i=0, self.sq:getObjects():size() -1 do
        local obj = self.sq:getObjects():get(i)
        if obj:getName() == ISWaterDitch.dirtFillName or 
           obj:getTextureName() == ISWaterDitch.dirtFillSprite or
           obj:getModData().objectName == ISWaterDitch.dirtFillName then
            table.insert(removes, obj)
        end
    end

    for _, object in ipairs(removes) do
        self.sq:transmitRemoveItemFromSquare(object)
        self.sq:RemoveTileObject(object)
    end

    -- when use custom sprite (texture only) without `Tile`,
    -- the sprite cloud be disappear when character move far then come back.
    -- until re setSprite again. (it might take time, 10 min in game time in current system logic.)
    -- use overlay sprite can solved this problem, less client side, not test on server.
    self.javaObject = IsoThumpable.new(cell, self.sq, ISWaterDitch.baseSprite, north, self)
    self.javaObject:setCanPassThrough(self.canPassThrough)
    self.javaObject:setBlockAllTheSquare(self.blockAllTheSquare)
    self.javaObject:setName(self.name)
    self.javaObject:setIsThumpable(self.isThumpable)
    self.javaObject:setIsDismantable(self.dismantable)
    self.javaObject:setIsHoppable(self.hoppable)
	self.javaObject:setCanBarricade(self.canBarricade)
    self.javaObject:getModData().waterMax = self.waterMax
    self.javaObject:getSprite():setName(ISWaterDitch.baseSprite)
    self.javaObject:setOverlaySprite(sprite) -- use overloay sprite

    local variety = nil
    local ditchType = nil
    if self.isPool then
        variety = ISWaterDitch.variety['pool']
        ditchType = 'pool'
    elseif north then
        variety = ISWaterDitch.variety['NS']
        ditchType = 'NS'
    else
        variety = ISWaterDitch.variety['WE']
        ditchType = 'WE'
    end

    self.javaObject:getModData().waterMax = variety.waterMax
    self.javaObject:getModData().waterAmount = 0

    self.javaObject:getModData().sprites = variety.sprites
    self.javaObject:getModData().ditchType = ditchType

    self.javaObject:getModData().spriteName = ISWaterDitch.baseSprite
    self.javaObject:getModData().overlaySpriteName = sprite
    self.javaObject:getModData().objectName = self.name
    self.javaObject:setSpecialTooltip(true)

    self.sq:AddSpecialObject(self.javaObject)
    -- self.sq:getProperties():Set('BlocksPlacement', '')
    -- self.sq:getProperties():Set(IsoFlagType.solidtrans) -- seems NO working here.
    self.sq:RecalcProperties()
    self.sq:RecalcAllWithNeighbours(true)

    self.javaObject:transmitCompleteItemToServer()

    -- OnObjectAdded event will create the SWaterDitchGlobalObject on the server.
    -- This is only needed for singleplayer which doesn't trigger OnObjectAdded.
    triggerEvent("OnObjectAdded", self.javaObject)

end


function ISWaterDitch:walkTo(x, y, z)
    local square = getCell():getGridSquare(x, y, z)
    return luautils.walkAdj(self.character, square)
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
    o.character = getSpecificPlayer(player)
    o.noNeedHammer = true
    o.ignoreNorth = false
    o.equipBothHandItem = shovel
    o.maxTime = 200
    o.isPool = not northSprite or sprite == northSprite
    o.waterMax = ISWaterDitch.waterMax
    o.isThumpable = true  -- false will not block the square. and must setName to the JavaObject.
    o.canPassThrough = false
	o.blockAllTheSquare = true
    o.dismantable = false
    o.hoppable = false
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

    if CWaterDitchSystem.instance:getLuaObjectOnSquare(square) then
        return false
    end

    if CFarmingSystem.instance:getLuaObjectOnSquare(square) then
		return false
	end

    if not square:isFreeOrMidair(true, true) then return false end

    local floor = square:getFloor()
    if not ISBuildingObject.isValid(self, square) or not ISWaterDitch.isValidFloorTexture(floor) then
        return false
    end

    if not ISWaterDitch.shovelledFloorCanDig(square) then
        return false
    end

    if buildUtil.stairIsBlockingPlacement(square, true) then 
        return false
    end
    
    local spriteName = self:getSprite()
    if spriteName == ISWaterDitch.variety.NS.sprites.empty then
        local north_square = square:getAdjacentSquare(IsoDirections.N)
        local south_square = square:getAdjacentSquare(IsoDirections.S)
        local ditch_type = {'pool', 'NS'}
        if not ISWaterDitch.getDitch(north_square, ditch_type) and 
           not ISWaterDitch.getDitch(south_square, ditch_type) then
            return false
        end
    elseif spriteName == ISWaterDitch.variety.WE.sprites.empty then
        local west_square = square:getAdjacentSquare(IsoDirections.W)
        local east_square = square:getAdjacentSquare(IsoDirections.E)
        local ditch_type = {'pool', 'WE'}
        if not ISWaterDitch.getDitch(west_square, ditch_type) and 
           not ISWaterDitch.getDitch(east_square, ditch_type) then
            return false
        end
    end
    return true
end


function ISWaterDitch.recognizeDitch(object)
    local ditchType = object:getModData().ditchType
    
    if not ditchType then
        local spriteName = object:getSpriteName()
        ditchType = ISWaterDitch.varietySpriteMap[spriteName] or ISWaterDitch.defaultVariety
    end
    local variety = ISWaterDitch.variety[ditchType]
    object:getModData().waterMax = variety.waterMax
    object:getModData().sprites = variety.sprites
    object:getModData().ditchType = ditchType
end


function ISWaterDitch.getAdjacentSquarePos(ditch)
    if not ditch or not ditch:getSquare() then
        return {}
    end

    local square = ditch:getSquare()
    local adjacent_squares = {
        N = square:getAdjacentSquare(IsoDirections.N),
        S = square:getAdjacentSquare(IsoDirections.S),
        W = square:getAdjacentSquare(IsoDirections.W),
        E = square:getAdjacentSquare(IsoDirections.E),
        NE = square:getAdjacentSquare(IsoDirections.NE),
        NW = square:getAdjacentSquare(IsoDirections.NW),
        SE = square:getAdjacentSquare(IsoDirections.SE),
        SW = square:getAdjacentSquare(IsoDirections.SW),
    }

    local adjacent_pos = {}
    for k, sq in pairs(adjacent_squares) do
        if sq then
            adjacent_pos[k] = {x=sq:getX(), y=sq:getY(), z=sq:getZ()}
        end
    end

    return adjacent_pos
end


function ISWaterDitch.getTouchedRiverCount(ditch)
    if not ditch or not ditch:getSquare() then
        return 0
    end
    local square = ditch:getSquare()
    local riverSquares = RC.findSquaresRadius(square, 1, ISWaterDitch.isRiverSquare)
    return #riverSquares
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


function ISWaterDitch.getDitch(square, ditchTypes)
    if type(ditchTypes) == 'string' then
        ditchTypes = {ditchTypes}
    elseif ditchTypes == true then
        ditchTypes = {'pool'}
    elseif type(ditchTypes) ~= 'table' then
        ditchTypes = {}
    end
    if square then
        for i=0, square:getObjects():size()-1 do
            local object = square:getObjects():get(i)
            if object:getName() == "Water Ditch" then
                if #ditchTypes == 0 or RC.tableIndexOf(ditchTypes, object:getModData().ditchType) then
                    return object
                end
            end
        end
    end
    return nil
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


function ISWaterDitch.canSkill(playerObj)
    return playerObj:getPerkLevel(Perks.Farming) >= ISWaterDitch.skillRequired
end
