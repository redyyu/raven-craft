
require "BuildingObjects/ISBSFurnace.lua"


function ISBSFurnace:create(x, y, z, north, sprite)
    local cell = getWorld():getCell()
    self.sq = cell:getGridSquare(x, y, z)

    -- for block movements
    local floor_sprite = 'camping_01_6'
    local floor_olsprite = 'crafted_01_40'
    local floor_name = 'FurnaceFloor'

    local furnace_floor = IsoObject.new(self.sq, floor_sprite, floor_name)
    self.sq:AddTileObject(furnace_floor)

    furnace_floor:setOverlaySprite(floor_olsprite)
    furnace_floor:getModData().spriteName = floor_sprite
    furnace_floor:getModData().overlaySpriteName = floor_olsprite
    furnace_floor:getModData().objectName = floor_name

    self.javaObject = BSFurnace.new(cell, self.sq, self.sprite, self.litSprite)
    buildUtil.consumeMaterial(self)

    if isClient() then
        furnace_floor:transmitCompleteItemToServer()
        self.javaObject:transmitCompleteItemToServer()
    end
    
    self.sq:RecalcProperties()
    self.sq:RecalcAllWithNeighbours(true)
    print(self.sq:Is("BlocksPlacement"))
    print("======================================")
end