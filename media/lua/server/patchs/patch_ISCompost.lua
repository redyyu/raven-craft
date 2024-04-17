
require "BuildingObjects/ISCompost.lua"

function ISCompost:isValid(square)
	if not square then return false end
    if square:HasStairs() then return false end
    if square:HasTree() then return false end
    if square:isSolid() or square:isSolidTrans() then return false end
    if not square:getMovingObjects():isEmpty() then return false end
    if not square:TreatAsSolidFloor() then return false end

    if buildUtil.stairIsBlockingPlacement(square, true) then 
        return false
    end
    
	return ISBuildingObject.isValid(self, square)
end
