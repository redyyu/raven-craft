
require "BuildingObjects/ISBSFurnace.lua"


function ISBSFurnace:create(x, y, z, north, sprite)
    local cell = getWorld():getCell()
    self.sq = cell:getGridSquare(x, y, z)

    local furncae_ground_name = 'Furnace Ground'
    local furncae_ground_sprite = 'crafted_01_40'  -- for solidTrans (block movemnts)
    -- when furncace is lit or put out fire, the square is not block movements anymore.
    -- I guess that's because the BSFurnce not work properly.
    -- to fix that by add another isoObject with solidTrans under layer.
    
    local furncae_core_name = 'Furnace Core'
    local furncae_core_sprite = 'constructedobjects_01_0' -- for BlocksPlacement
    
    local furncae_ground = IsoObject.new(self.sq, furncae_ground_sprite, furncae_ground_name)
    self.sq:AddTileObject(furncae_ground)

    furncae_ground:getModData().spriteName = furncae_ground_sprite
    furncae_ground:getModData().objectName = furncae_ground_name

    local furncae_core = IsoObject.new(self.sq, furncae_core_sprite, furncae_core_name)
    self.sq:AddTileObject(furncae_core)

    furncae_core:getModData().spriteName = furncae_core_sprite
    furncae_core:getModData().objectName = furncae_core_name

    self.javaObject = BSFurnace.new(cell, self.sq, self.sprite, self.litSprite)
    -- Useless .....
    -- self.javaObject:getProperties():Set("BlocksPlacement", "")
    -- self.javaObject:getSprite():getProperties():Set("BlocksPlacement", "")
    buildUtil.consumeMaterial(self)

    if isClient() then
        furncae_core:transmitCompleteItemToServer()
        furncae_ground:transmitCompleteItemToServer()
        self.javaObject:transmitCompleteItemToServer()
    end
    
    self.sq:RecalcProperties()
    self.sq:RecalcAllWithNeighbours(true)
end

-- NO working with destroy menu.
-- ISBSFurnace.onDestroy = function(furncae)
--     print("===============BSFurnace============= ")
--     if instanceof(furncae, 'BSFurnace') then
--         print("===============BSFurnace=============")
--     end
-- end


-- Events.OnDestroyIsoThumpable.Add(ISBSFurnace.onDestroy)