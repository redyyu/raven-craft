
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

    for i=0, square:getSpecialObjects():size()-1 do
        local obj = square:getSpecialObjects():get(i)
        local props = obj:getProperties()
        if props then
            if (props:Is('BlocksPlacement') and not props:Is('IsHigh')) or props:Is('tree') then
                return false
            end
        end
    end
    
	return ISBuildingObject.isValid(self, square)
end
