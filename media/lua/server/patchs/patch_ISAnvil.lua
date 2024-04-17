
require "BuildingObjects/ISAnvil.lua"

function ISAnvil:create(x, y, z, north, sprite)
    local cell = getWorld():getCell()
    self.sq = cell:getGridSquare(x, y, z)
    self.javaObject = IsoThumpable.new(cell, self.sq, sprite, north, self)
    self.javaObject:setName(self.name)
    self.javaObject:setCanPassThrough(false)
    self.javaObject:setBlockAllTheSquare(true)
    self.javaObject:setIsThumpable(true)
    self.javaObject:setIsDismantable(false)
    self.javaObject:setIsHoppable(false)
	self.javaObject:setCanBarricade(false)

    buildUtil.consumeMaterial(self)

    self.sq:AddSpecialObject(self.javaObject)

    if isClient() then
        self.javaObject:transmitCompleteItemToServer()
    end
    
    self.sq:RecalcProperties()
    self.sq:RecalcAllWithNeighbours(true)
end


function ISAnvil:isValid(square)
    if not square then return false end
    if not ISBuildingObject.isValid(self, square) then return false end
    if square:isSolid() or square:isSolidTrans() then return false end
    if square:HasStairs() then return false end
    if square:HasTree() then return false end
    if not square:getMovingObjects():isEmpty() then return false end
    if not square:TreatAsSolidFloor() then return false end
    if not self:haveMaterial(square) then return false end
    for i=0, square:getSpecialObjects():size()-1 do
        local obj = square:getSpecialObjects():get(i-1)
        if self.name == obj:getName() or self:getSprite() == obj:getTextureName() then
            return false
        end
    end
    
    if buildUtil.stairIsBlockingPlacement(square, true) then
        return false
    end

    return true
end