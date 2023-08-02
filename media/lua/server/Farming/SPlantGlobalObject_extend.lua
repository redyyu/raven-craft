if isClient() then return end

require "Farming/SFarmingSystem"
require "Map/SPlantGlobalObject"


-- Override growPlant
function SFarmingSystem:growPlant(luaObject, nextGrowing, updateNbOfGrow)
	if(luaObject.state == "seeded") then
		local new = luaObject.nbOfGrow <= 0
		if(luaObject.typeOfSeed == "Carrots") then
			luaObject = farming_vegetableconf.growCarrots(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Broccoli") then
			luaObject = farming_vegetableconf.growBroccoli(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Strawberry plant") then
			luaObject = farming_vegetableconf.growStrewberries(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Radishes") then
			luaObject = farming_vegetableconf.growRedRadish(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Tomato") then
			luaObject = farming_vegetableconf.growTomato(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Potatoes") then
			luaObject = farming_vegetableconf.growPotato(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Cabbages") then
			luaObject = farming_vegetableconf.growCabbage(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Corn") then
			luaObject = farming_vegetableconf.growCorn(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Wheat") then
			luaObject = farming_vegetableconf.growWheat(luaObject, nextGrowing, updateNbOfGrow)
		end
		-- maybe this plant gonna be disease
		if not new and luaObject.nbOfGrow > 0 then
			self:diseaseThis(luaObject, true)
		end
		luaObject.nbOfGrow = luaObject.nbOfGrow + 1
	end
end


-- Override rottenThis
function SPlantGlobalObject:rottenThis()
	local texture = nil
	if self.typeOfSeed == "Carrots" then
		texture = "vegetation_farming_01_13"
	elseif self.typeOfSeed == "Broccoli" then
		texture = "vegetation_farming_01_23"
	elseif self.typeOfSeed == "Strawberry plant" then
		texture = "vegetation_farming_01_63"
	elseif self.typeOfSeed == "Radishes" then
		texture = "vegetation_farming_01_39"
	elseif self.typeOfSeed == "Tomato" then
		texture = "vegetation_farming_01_71"
	elseif self.typeOfSeed == "Potatoes" then
		texture = "vegetation_farming_01_47"
	elseif self.typeOfSeed == "Cabbages" then
		texture = "vegetation_farming_01_31"
	elseif self.typeOfSeed == "Corn" then
		texture = "vegetation_farming_01_79"
	elseif self.typeOfSeed == "Wheat" then
		texture = "vegetation_farm_01_34"
	end
	self:setSpriteName(texture)
	self.state = "rotten"
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
end
