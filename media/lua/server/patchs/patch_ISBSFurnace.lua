
require "BuildingObjects/ISBSFurnace.lua"


function ISBSFurnace:create(x, y, z, north, sprite)
    local cell = getWorld():getCell()
    self.sq = cell:getGridSquare(x, y, z)

    local furncae_ground_name = 'Furnace Ground'
    local furncae_ground_sprite = 'crafted_01_40'  -- for solidTrans (block movemnts)
    -- when furncace is lit or put out fire, the square is not block movements anymore.
    -- I guess that's because the BSFurnce not work properly.
    -- to fix that by add another isoObject with solidTrans under layer.
        
    local furncae_ground = IsoObject.new(self.sq, furncae_ground_sprite, furncae_ground_name)
    self.sq:AddTileObject(furncae_ground)

    furncae_ground:getModData().spriteName = furncae_ground_sprite
    furncae_ground:getModData().objectName = furncae_ground_name

    self.javaObject = BSFurnace.new(cell, self.sq, self.sprite, self.litSprite)

    buildUtil.consumeMaterial(self)

    -- NO NEED this, `BSFurnace.new` already added to square,
    -- it will add duplicated object.
    -- self.sq:AddSpecialObject(self.javaObject)

    if isClient() then
        furncae_ground:transmitCompleteItemToServer()
        self.javaObject:transmitCompleteItemToServer()
    end
    
    self.sq:RecalcProperties()
    self.sq:RecalcAllWithNeighbours(true)
end


function ISBSFurnace:isValid(square)
    if not square then return false end
    if not ISBuildingObject.isValid(self, square) then return false end
    if square:isSolid() or square:isSolidTrans() then return false end
    if square:HasStairs() then return false end
    if square:HasTree() then return false end
    if not square:getMovingObjects():isEmpty() then return false end
    if not square:TreatAsSolidFloor() then return false end
    if not self:haveMaterial(square) then return false end

    for i=0, square:getSpecialObjects():size()-1 do
        local obj = square:getSpecialObjects():get(i)
        local props = obj:getProperties()
        if instanceof(obj, 'BSFurnace') or self.name == obj:getName() or self:getSprite() == obj:getTextureName() then
            return false
        elseif props then
            if props:Is('BlocksPlacement') or props:Is('tree') then
                return false
            end
        end
    end

    if buildUtil.stairIsBlockingPlacement(square, true) then
        return false
    end

    return true
end

-- NO working with destroy menu.
-- ISBSFurnace.onDestroy = function(furncae)
--     if instanceof(furncae, 'BSFurnace') then
--     end
-- end


-- Events.OnDestroyIsoThumpable.Add(ISBSFurnace.onDestroy)