
require "BuildingObjects/ISWoodenContainer.lua"

function ISWoodenContainer:isValid(square)
    if not square then return false end
    if square:HasStairs() then return false end
    if square:HasTree() then return false end
    -- if square:isSolid() or square:isSolidTrans() then return false end
    if not square:getMovingObjects():isEmpty() then return false end -- such as player.
    if not square:TreatAsSolidFloor() then return false end

    if buildUtil.stairIsBlockingPlacement(square, true) then 
        return false
    end

    if square:isSolid() or square:isSolidTrans() then
        local has_stackable = false
        for i=0, square:getSpecialObjects():size()-1 do
            local obj = square:getSpecialObjects():get(i)
            local spr = obj:getSprite()
            if spr and spr:getProperties() and spr:getProperties():Is("IsStackable") then
                has_stackable = true
            end
        end
        if not has_stackable then
            return false
        end
    end

	if not self:haveMaterial(square) then return false end
	local sharedSprite = getSprite(self:getSprite())
	if sharedSprite and sharedSprite:getProperties():Is("IsStackable") then
		local props = ISMoveableSpriteProps.new(sharedSprite)
		return props:canPlaceMoveable("bogus", square, nil)
	end
    
	return ISBuildingObject.isValid(self, square)
end