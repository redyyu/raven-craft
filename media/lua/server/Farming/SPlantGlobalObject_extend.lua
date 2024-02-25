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
		elseif(luaObject.typeOfSeed == "Peanuts") then
			luaObject = farming_vegetableconf.growCorn(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Wheat") then
			luaObject = farming_vegetableconf.growWheat(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Zucchini") then
			luaObject = farming_vegetableconf.growZucchini(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Pumpkin") then
			luaObject = farming_vegetableconf.growPumpkin(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Watermelon") then
			luaObject = farming_vegetableconf.growWatermelon(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Onion") then
			luaObject = farming_vegetableconf.growOnion(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Lettuce") then
			luaObject = farming_vegetableconf.growLettuce(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Leek") then
			luaObject = farming_vegetableconf.growLeek(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Eggplant") then
			luaObject = farming_vegetableconf.growEggplant(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Edamame") then
			luaObject = farming_vegetableconf.growEdamame(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Daikon") then
			luaObject = farming_vegetableconf.growDaikon(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "PepperJalapeno") then
			luaObject = farming_vegetableconf.growPepperJalapeno(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "PepperHabanero") then
			luaObject = farming_vegetableconf.growPepperHabanero(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "BellPepper") then
			luaObject = farming_vegetableconf.growBellPepper(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Apple") then
			luaObject = farming_vegetableconf.growApple(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Banana") then
			luaObject = farming_vegetableconf.growBanana(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Grapefruit") then
			luaObject = farming_vegetableconf.growGrapefruit(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Grapes") then
			luaObject = farming_vegetableconf.growGrapes(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Lemon") then
			luaObject = farming_vegetableconf.growLemon(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Orange") then
			luaObject = farming_vegetableconf.growOrange(luaObject, nextGrowing, updateNbOfGrow)
		elseif(luaObject.typeOfSeed == "Peach") then
			luaObject = farming_vegetableconf.growPeach(luaObject, nextGrowing, updateNbOfGrow)
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
	elseif self.typeOfSeed == "Peanuts" then
		texture = "vegetation_farming_01_47"
	elseif self.typeOfSeed == "Wheat" then
		texture = "vegetation_farm_01_34"
	elseif self.typeOfSeed == "Zucchini" then
		texture = "vegetation_farming_01_71"
	elseif self.typeOfSeed == "Pumpkin" then
		texture = "rc_vegetation_farming_pumpkin_7"
	elseif self.typeOfSeed == "Watermelon" then
		texture = "rc_vegetation_farming_watermelon_7"
	elseif self.typeOfSeed == "Onion" then
		texture = "vegetation_farming_01_55"
	elseif self.typeOfSeed == "Lettuce" then
		texture = "vegetation_farming_01_23"
	elseif self.typeOfSeed == "Leek" then
		texture = "vegetation_farming_01_39"
	elseif self.typeOfSeed == "Eggplant" then
		texture = "rc_vegetation_farming_eggplant_7"
	elseif self.typeOfSeed == "Edamame" then
		texture = "vegetation_farming_01_71"
	elseif self.typeOfSeed == "Daikon" then
		texture = "vegetation_farming_01_55"
	elseif self.typeOfSeed == "PepperJalapeno" then
		texture = "vegetation_farming_01_71"
	elseif self.typeOfSeed == "PepperHabanero" then
		texture = "vegetation_farming_01_71"
	elseif self.typeOfSeed == "BellPepper" then
		texture = "vegetation_farming_01_71"
	elseif self.typeOfSeed == "Apple" then
		texture = "rc_vegetation_farming_apple_7"
	elseif self.typeOfSeed == "Banana" then
		texture = "rc_vegetation_farming_banana_7"
	elseif self.typeOfSeed == "Grapefruit" then
		texture = "rc_vegetation_farming_grapefruit_7"
	elseif self.typeOfSeed == "Grapes" then
		texture = "rc_vegetation_farming_grapes_7"
	elseif self.typeOfSeed == "Lemon" then
		texture = "rc_vegetation_farming_lemon_7"
	elseif self.typeOfSeed == "Orange" then
		texture = "rc_vegetation_farming_orange_7"
	elseif self.typeOfSeed == "Peach" then
		texture = "rc_vegetation_farming_peach_7"
	end
	self:setSpriteName(texture)
	self.state = "rotten"
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
end
