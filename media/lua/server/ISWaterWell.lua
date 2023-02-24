ISWaterWell = ISBuildingObject:derive("ISWaterWell");


function ISWaterWell:create(x, y, z, north, sprite)
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self.javaObject = IsoThumpable.new(cell, self.sq, sprite, north, self);
	buildUtil.setInfo(self.javaObject, self);
	buildUtil.consumeMaterial(self);
	self.javaObject:setMaxHealth(self:getHealth());
	self.javaObject:setHealth(self.javaObject:getMaxHealth());
	self.javaObject:setBreakSound("BreakObject");
    self.sq:AddSpecialObject(self.javaObject);
	
	self.javaObject:transmitCompleteItemToServer();
end

function ISWaterWell:removeFromGround(square)
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
		end
	end
end

function ISWaterWell:new(name, sprite)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite);
	o:setNorthSprite(sprite);
	o.name = name;
	o.dismantable = true;
	o.blockAllTheSquare = true;
	o.buildLow = true;
    o.canPassThrough = false;
    o.canBarricade = false;
    o.ignoreNorth = true;
    o.canBeAlwaysPlaced = false;
    o.isThumpable = false;
	return o;
end


function ISWaterWell:getHealth()
	return 50000;
end

function ISWaterWell:isValid(square)
    if square:getZ() > 0 then
		return false
	end
	if not ISWaterWell.isValidZone(square) then
		return false;
	end
    local floor = square:getFloor();
	if not ISBuildingObject.isValid(self, square) or
			not (luautils.stringStarts(floor:getTextureName(), "floors_exterior_natural") or
			luautils.stringStarts(floor:getTextureName(), "blends_natural_01")) then
		return false
	end
    if not ISWaterWell.shovelledFloorCanDig(square) then
		return false;
	end
    if buildUtil.stairIsBlockingPlacement(square, true) then return false; end
	if not ISBuildingObject.isValid(self, square) then return false; end
	if not buildUtil.canBePlace(self, square) then return false; end
    return true;
end

-- Wells should not be able to be placed on roads, towns or trailer parks
function ISWaterWell.isValidZone(square)
	local squareZone = square:getZoneType();
	if squareZone == "Nav" or squareZone == "TownZone" or squareZone == "TrailerPark" then return false; end
	return true;
end

-- Wells should not be able to be placed over graves
function ISWaterWell.shovelledFloorCanDig(square)
	if (not square) or (not square:getFloor()) then
		return false;
	end
	if square:isInARoom() then
		return false;
	end
	local floor = square:getFloor();
	local sprites = floor:getModData() and floor:getModData().shovelledSprites;
	if sprites then
		for i=1,#sprites do
			local sprite = sprites[i];
			if luautils.stringStarts(sprite, "floors_exterior_natural") or luautils.stringStarts(sprite, "blends_natural_01") then
				return true;
			end
		end
		return false;
	else
		return true;
	end
end

function ISWaterWell:render(x, y, z, square)
	ISBuildingObject.render(self, x, y, z, square)
end
